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
#  +- /service/tinydns
#    +- log
#    +- env
#    +- root
#      + Makefile
#      + data
#      + data.cdb
#      + primary.d
#      | +- domainx.data
#      | +- domainy.data
#      | +- domainz.data
#      | +- ...
#      + secondary.d
#        +- domaina.data
#        +- domainb.data
#        +- domainc.data
#        +- ...
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
TINYDNS_DIR="/var/djbdns/tinydns-external"

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

if [ ! -f "${TINYDNS_DIR}/root/Makefile" ] ; then
  echo "Makefile not present in the TinyDNS directory ${TINYDNS_DIR}/root"
  exit 1;
fi

# If 'my' server isn't set, then take the first non-comment, non-blank line
# from the IP file as the address of 'my' server.
if [ ! -n "${ME}" ] ; then
  ME="`egrep --invert-match '^ *(#|$)' ${TINYDNS_DIR}/env/IP | head -n 1`"
fi

if [ ! -n "${ME}" ] ; then
  echo "The address of this name server is not defined"
  exit 1;
fi
[ -n "$VERBOSE" ] && echo "Using TinyDNS server ${ME}"

if [ ! -n "${SECONDARY_ZONES}" ] ; then
  echo "No secondary zones defined"
  exit 1;
fi

#
# Create directories (if they don't exist) to store primary
# and secondary dns zone data.
#
[ -d "${TINYDNS_DIR}/root/primary.d"   ] || mkdir -p "${TINYDNS_DIR}/root/primary.d"
[ -d "${TINYDNS_DIR}/root/secondary.d" ] || mkdir -p "${TINYDNS_DIR}/root/secondary.d"

#
#  For each of the secondary zones in the configuration
#
[ -n "$VERBOSE" ] && echo "Using zones ${SECONDARY_ZONES}"
for ZONE in `echo "$SECONDARY_ZONES" | sed -e "s/:/ /g"` ; do

  DOMAIN="${ZONE%%,*}"
  PRIMARY="${ZONE#*,}"
  [ -n "$VERBOSE" ] && echo "Check domain ${DOMAIN} at ${PRIMARY}"


  # Read the serial number from the primary server and our server
  DOMAIN_SOA=$( (/usr/bin/dig ${DOMAIN} soa +short @${PRIMARY} | /bin/awk '{ print $3 }' | egrep "^[0-9]+$" ) || echo "" )
  MY_SOA=$( (/usr/bin/dig ${DOMAIN} soa +short @${ME} | /bin/awk '{ print $3 }' |  egrep "^[0-9]+$" ) || echo "" )
  [ -n "$VERBOSE" ] && echo "  Domain ${DOMAIN} SOA is ${DOMAIN_SOA} (Current is ${MY_SOA})"

  # Check if we have the latest serial
  if [ -n "${DOMAIN_SOA}" -a -n "${MY_SOA}" -a "${DOMAIN_SOA}" == "${MY_SOA}" ] ; then

    # We have the latest serial number, so we don't need to perform an AXFR
    # operation to get the entire zone.
    [ -n "$VERBOSE" ] && echo "  Domain ${DOMAIN} is up to date (SOA is ${MY_SOA})" ;

  else

    [ -n "$VERBOSE" ] && echo "  Fetching zone data for ${DOMAIN} from ${PRIMARY}"

    # Attempt to:
    #   - transfer the zone info
    #   - remove duplicate entries from the data
    #   - remove entries that aren't for the domain
    #   - finally, move it to be the 'cuurent' zone information
    #
    ( tcpclient -R -T 5+15 ${PRIMARY} 53 \
        axfr-get ${DOMAIN} \
          "${TINYDNS_DIR}/root/secondary.d/${DOMAIN}.cache" \
          "${TINYDNS_DIR}/root/secondary.d/${DOMAIN}.cache.tmp" ) && \
      sort -ur < "${TINYDNS_DIR}/root/secondary.d/${DOMAIN}.cache" | \
        egrep "^.[^:]*${DOMAIN}:" > "${TINYDNS_DIR}/root/secondary.d/.${DOMAIN}.data.tmp" && \
      mv "${TINYDNS_DIR}/root/secondary.d/.${DOMAIN}.data.tmp" \
        "${TINYDNS_DIR}/root/secondary.d/${DOMAIN}.data"

  fi
done

#
#  Concatenate all the primary and secondary zone files together
#
[ -n "$VERBOSE" ] && echo "Primary zones:"
rm -f "${TINYDNS_DIR}/root/.data.tmp"
for PRIMARY in "${TINYDNS_DIR}/root/primary.d"/*.data ; do
  STAMP="`ls  --time-style=+%s -G  -o -g  $PRIMARY | /bin/awk '{ print $4 }'`"
  [ -n "$VERBOSE" ] && echo "  ${PRIMARY} serial ${STAMP}"
  echo "# Primary zone file $PRIMARY with timestamp of $STAMP" >> "${TINYDNS_DIR}/root/.data.tmp"
  /bin/sed -r -e  "s/^(Z[^:]*:[^:]*:[^:]*)::(.*)$/\1:${STAMP}:\2/g" < $PRIMARY >> "${TINYDNS_DIR}/root/.data.tmp"
done
cat "${TINYDNS_DIR}/root/secondary.d"/*.data >> "${TINYDNS_DIR}/root/.data.tmp"

#
# If the master 'data' file is not present, or is different to the one
# generated above, then use the new data from the concantenated zone
# files, and compile it into a database.
#
if [ ! -f "${TINYDNS_DIR}/root/data" ] || \
  ! ( /usr/bin/diff -q "${TINYDNS_DIR}/root/.data.tmp" "${TINYDNS_DIR}/root/data" > /dev/null ) ; then

  [ -n "$VERBOSE" ] && echo "Building new TinyDNS database"
  mv "${TINYDNS_DIR}/root/.data.tmp" "${TINYDNS_DIR}/root/data"
  if [ -n "$VERBOSE" ] ; then
    make -C "${TINYDNS_DIR}/root"
  else
    make -C "${TINYDNS_DIR}/root" > /dev/null
  fi
else
  [ -n "$VERBOSE" ] && echo "No changes to zone data"
fi


[ -n "$VERBOSE" ] && echo "Done"