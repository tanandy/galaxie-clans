#!/usr/bin/env bash
#
# https://plone.lucidsolutions.co.nz/linux/dns/creating-a-djb-tiny-dns-primary-secondary-server
#
# $Id: refreshzones 28 2008-05-04 15:08:08Z greg $
#
# A script to support multiple primary and secondary
# domains. This works with a standard TinyDNS directory
# structure. Any exisiting  'data' file MUST be moved
# into the primary.d directory (or it will be lost).
#
# Place primary domain 'data' files into the primary.d
# directory, with an extensions of '.data'. These files
# must be manually edited.
#
# Domains for which the TinyDNS server will act as a
# secondary via AXFR, will automatically be transfered
# into the secondary.d directory.
#
# Prior to performing any zone transfers, the script will query the master
# nameserver for the zone for a serial (from the SOA record). If the serial
# is the same (and valid) then the zone transfer is not performed. This means
# that the zone transfers will only occur when a zones changes (keeping thw
# whole process light weight.
#
#  +- /etc/ndjbdns
#  +- Makefile
#  +- data
#  +- data.cdb
#  +- zones
#     + primary.d
#     | +- domainx.data
#     | +- domainy.data
#     | +- domainz.data
#     | +- ...
#     + secondary.d
#       +- domaina.data
#       +- domainb.data
#       +- domainc.data
#       +- ...
#  +- /var/log/tinydns.log
#
# The primary zone files SHOULD have a SOA record ('Z') with the serial number
# field ('ser') empty. This script will replace the serial number with the
# date of the primary file.
#
#  e.g. 'Zdomain.com:a.ns.domain.com.:hostmaster.domain.com.::::::'
#
# see http://cr.yp.to/djbdns/tinydns-data.html

#
# Configure the zones here, or on the command line
#
SECONDARY_ZONES=""

#
# My DNS server to query. This is the server that we query prior to performing
# a zone transfer to check if we have the current zone data.
#
ME=

#
# The location of the TinyDNS service.
#
TINYDNS_DIR="{{ glx_tinydns_root_directory }}"
TINYDNS_ZONES_PRIMARY_DIR="{{ glx_tinydns_primary_directory }}"
TINYDNS_ZONES_SECONDARY_DIR="{{ glx_tinydns_secondary_directory }}"

set -e

#
# Parse switches
#
while [ "$1" != "${1##-}" ] ; do # loop over options
    case $1 in
        -v)
                VERBOSE=yes
        ;;

        --zones)
                shift
                SECONDARY_ZONES="$1"
        ;;

        --server)
                shift
                ME="$1"
        ;;

        --tinydnsdir)
                shift
                TINYDNS_DIR="$1"
        ;;

        -h)
                echo "Usage: $0 [-v] [-h] [--zones domain,primary:domain,primary:...] [--server hostname] [--tinydnsdir dir]"
                exit 1;
        ;;

        *)
                echo "Warning: Unknown option $1"
                exit 10;
        ;;

    esac
    shift
done


#
# Check things are sane and where we expected
#
if [ ! -d "${TINYDNS_DIR}" ] ; then
    echo "Tiny DNS directory ${TINYDNS_DIR} not found"
    exit 1;
fi
[ -n "$VERBOSE" ] && echo "Using TinyDNS directory ${TINYDNS_DIR}"

if [ ! -f "${TINYDNS_DIR}/Makefile" ] ; then
    echo "Makefile not present in the TinyDNS directory ${TINYDNS_DIR}"
    exit 1;
fi

# If 'my' server isn't set, then take the first non-comment, non-blank line
# from the IP file as the address of 'my' server.
if [ ! -n "${ME}" ] ; then
    if [ ! -f "${TINYDNS_DIR}/tinydns.conf" ] ; then
        echo "TinyDNS config file tinydns.conf is not present in the directory ${TINYDNS_DIR}"
    else
        #ME="`egrep --invert-match '^ *(#|$)' ${TINYDNS_DIR}/env/IP | head -n 1`"
        ME="`egrep "^IP=" ${TINYDNS_DIR}/tinydns.conf | cut -d'=' -f2-`"
    fi
fi

if [ ! -n "${ME}" ] ; then
    echo "The address of this name server is not defined"
    exit 1;
fi
[ -n "$VERBOSE" ] && echo "Using TinyDNS server ${ME}"

#if [ ! -n "${SECONDARY_ZONES}" ] ; then
#  echo "No secondary zones defined"
#  #exit 1;
#fi

#
# Create directories (if they don't exist) to store primary
# and secondary dns zone data.
#
[ -d "${TINYDNS_DIR}/zones/primary.d"   ] || mkdir -p "${TINYDNS_DIR}/zones/primary.d"
[ -d "${TINYDNS_DIR}/zones/secondary.d" ] || mkdir -p "${TINYDNS_DIR}/zones/secondary.d"

#
# Concatenate all the primary and secondary zone files together
# add primary file zone
[ -n "$VERBOSE" ] && echo "Primary zones:"
rm -f "${TINYDNS_DIR}/.data.tmp"
if [ $(ls -1A ${TINYDNS_DIR}/zones/primary.d/ | wc -l) -gt 0 ] ; then
    echo "# Primary zone files:" >> "${TINYDNS_DIR}/.data.tmp"
    for PRIMARY in "${TINYDNS_DIR}/zones/primary.d"/*.data ; do
        # Generate serial
        STAMP="`ls  --time-style=+%s -G  -o -g  $PRIMARY | awk '{ print $4 }'`"
        [ -n "$VERBOSE" ] && echo "  ${PRIMARY} serial ${STAMP}"
        sed -r -e  "s/^(Z[^:]*:[^:]*:[^:]*)::(.*)$/\1:${STAMP}:\2/g" < $PRIMARY > "$PRIMARY.tosend"
        echo "# Primary zone file $PRIMARY with timestamp of $STAMP" >> "${TINYDNS_DIR}/.data.tmp"
        cat "$PRIMARY.tosend" >> "${TINYDNS_DIR}/.data.tmp"
    done
else
    [ -n "$VERBOSE" ] && echo "  no file zone ..."
fi
### add secondary file zone
[ -n "$VERBOSE" ] && echo "Secondary zones:"
if [ $(ls -1A ${TINYDNS_DIR}/zones/secondary.d/ | wc -l) -gt 0 ] ; then
    echo "# Secondary zone files:" >> "${TINYDNS_DIR}/.data.tmp"
    for file in ${TINYDNS_DIR}/zones/secondary.d/*.data ; do
        [ -n "$VERBOSE" ] && echo "  $file"
        echo "# $file" >> "${TINYDNS_DIR}/.data.tmp"
	    cat "$file" >> "${TINYDNS_DIR}/.data.tmp"
    done
else
    [ -n "$VERBOSE" ] && echo "  no file zone ..."
fi
#
# If the master 'data' file is not present, or is different to the one
# generated above, then use the new data from the concantenated zone
# files, and compile it into a database.
#
if [ ! -f "${TINYDNS_DIR}/data" ] || \
    ! ( diff -q "${TINYDNS_DIR}/.data.tmp" "${TINYDNS_DIR}/data" > /dev/null ) ; then
    [ -n "$VERBOSE" ] && echo "Building new TinyDNS database"
    mv "${TINYDNS_DIR}/.data.tmp" "${TINYDNS_DIR}/data"
        if [ -n "$VERBOSE" ] ; then
            make -C "${TINYDNS_DIR}"
        else
            make -C "${TINYDNS_DIR}" > /dev/null
        fi
else
    [ -n "$VERBOSE" ] && echo "No changes to zone data"
fi

[ -n "$VERBOSE" ] && echo "Done"