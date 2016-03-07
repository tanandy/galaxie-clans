#!/usr/bin/env bash

# refreshzones  refresh tinydns zone files over ssh
# (c) Jérôme Ornech <tuux@rtnp.org>
#
#   This package is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
# https://plone.lucidsolutions.co.nz/linux/dns/creating-a-djb-tiny-dns-primary-secondary-server
#
# $Id: refreshzones 28 2008-05-04 15:08:08Z greg $
#
# A script to support multiple primary and secondary
# domains. This works with a standard "ndjbdns" directory
# structure. Any exisiting  'data' file MUST be moved
# into the primary.d directory (or it will be lost).
#
# Place primary domain 'data' files into the primary.d
# directory, with an extensions of '.data'. These files
# must be manually edited.
#
# Domains for which the tinydns server will act as a
# secondary, should be automatically be transfered
# into the secondary.d directory by a other server via ssh.
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
# see https://cr.yp.to/djbdns/tinydns-data.html
#
# The Makefile is supposate to deal with ssh
# see https://cr.yp.to/djbdns/run-server-bind.html
#
#

#
# The location of the tinydns service.
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
       -v|--version)
                echo "refreshzone v0.3 by Galaxie "
                exit 1;
        ;;
        --verbose)
                VERBOSE=yes
        ;;

        --tinydnsdir)
                shift
                TINYDNS_DIR="$1"
        ;;

        --primarydir)
                shift
                TINYDNS_ZONES_PRIMARY_DIR="$1"
        ;;

        --secondarydir)
                shift
                TINYDNS_ZONES_SECONDARY_DIR="$1"
        ;;

        -h|--help)
                cat <<-EOF
Usage: $0 [-v] [--help] [--tinydnsdir dir] [--primarydir dir] [--secondarydir dir] [--verbose]"
Info :
    -v --version   : print the script version
    -h --help      : display it message
    --tinydnsdir   : tinydns root dir , where is store data and data.cdb
    --primarydir   : directory where store primary servers zone files
    --secondarydir : directory where store secondary servers zone files
    --verbose      : display output messages if not nothing is display on the output
EOF
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
    echo "tinydns root directory ${TINYDNS_DIR} not found"
    exit 1;
fi

if [ ! -f "${TINYDNS_DIR}/Makefile" ] ; then
    echo "Makefile not present in the tinydns root directory ${TINYDNS_DIR}"
    exit 1;
fi

#
# Create directories (if they don't exist) to store primary
# and secondary dns zone data.
#
[ -d "$TINYDNS_ZONES_PRIMARY_DIR"   ] || mkdir -p "$TINYDNS_ZONES_PRIMARY_DIR"
[ -d "$TINYDNS_ZONES_SECONDARY_DIR" ] || mkdir -p "$TINYDNS_ZONES_SECONDARY_DIR"

#
# Concatenate all the primary and secondary zone files together
# add primary file zone
[ -n "$VERBOSE" ] && echo "Primary zones:"
rm -f "${TINYDNS_DIR}/.data.tmp"
if [ $(ls -1A $TINYDNS_ZONES_PRIMARY_DIR/ | wc -l) -gt 0 ] ; then
    echo "# Primary zone files:" >> "${TINYDNS_DIR}/.data.tmp"
    for PRIMARY in "$TINYDNS_ZONES_PRIMARY_DIR"/*.data ; do
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
if [ $(ls -1A $TINYDNS_ZONES_SECONDARY_DIR/ | wc -l) -gt 0 ] ; then
    echo "# Secondary zone files:" >> "${TINYDNS_DIR}/.data.tmp"
    for file in "$TINYDNS_ZONES_SECONDARY_DIR"/*.data ; do
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
    [ -n "$VERBOSE" ] && echo "Building new tinydns database"
    mv "${TINYDNS_DIR}/.data.tmp" "${TINYDNS_DIR}/data"
        if [ -n "$VERBOSE" ] ; then
            make -C "${TINYDNS_DIR}"
        else
            make -C "${TINYDNS_DIR}" > /dev/null
        fi
else
    [ -n "$VERBOSE" ] && echo "No changes to zone data"
fi