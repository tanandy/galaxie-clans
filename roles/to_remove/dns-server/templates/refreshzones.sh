#!/usr/bin/env bash

# refreshzones v0.4 refresh tinydns zone templates over ssh
# (c) Tuux from www.rtnp.org
#
# This package is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
# This script is provide like this without any warranty, you use it at your own risks.
#
# It script has been originaly white by The Plone® CMS
# https://plone.lucidsolutions.co.nz/linux/dns/creating-a-djb-tiny-dns-primary-secondary-server
# refreshzones 28 2008-05-04 15:08:08
#
# The script have been modified and be coupled with a Makefile generate by
# Ansible via Jinja templateb
# see https://raw.githubusercontent.com/Tuuux/galaxie/master/roles/dns-server/templates/Makefile.j2
# The Makefile is suppose to deal with ssh for transfert zone templates to
# secondary server. see https://cr.yp.to/djbdns/run-server-bind.html
#
# The script support multiple primary and secondary domains.
# This works with a standard "ndjbdns" directory structure.
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
# Any exisiting  'data' file MUST be moved into the ./zones/primary.d/
# directory (or it will be lost).
#
# Place primary domain 'data' zone templates into the ./zones/primary.d directory,
# with an extensions of '.data'. (e.g. ./zones/primary.d/domain.eu.org.data)
# These templates must be manually edited.
#
# Domains for which the tinydns server will act as a secondary, should be
# automatically be receive into the ./zones/secondary.d directory by a other
# server via ssh.
#
# Prior to performing any things, the script will parse the ./zones/primary.d/
# directory for search zone templates (extensions '.data') and generate a
# SOA serial number with the epoch date of the last modification for each zone
# templates, and write a other file with extensions '.data.tosend' it will be use
# by the Makefile in case of ssh transfert.
#
# The primary zone templates (e.g. ./zones/primary.d/*) SHOULD have a
# SOA record ('Z') with the serial number field ('ser') empty. This script will
# replace the serial number of each primary zone templates with it own last
# modification epoch date.
#
# e.g. 'Zdomain.eu.org:a.ns.domain.eu.org.:hostmaster.domain.eu.org.::::::'
#
# see https://cr.yp.to/djbdns/tinydns-data.html

###########################
# USER VARIABLES SETTINGS #
###########################

# The location of the tinydns root
# e.g. /etc/ndjbdns
TINYDNS_DIR="{{ glx_tinydns_root_directory }}"

# The location of directory where store primary zone templates
# e.g.  /etc/ndjbdns/zones/primary.d
TINYDNS_ZONES_PRIMARY_DIR="{{ glx_tinydns_primary_directory }}"

# e.g. /etc/ndjbdns/zones/secondary.d
# The location of directory where store seconday zone templates
TINYDNS_ZONES_SECONDARY_DIR="{{ glx_tinydns_secondary_directory }}"

set -e

####################################################
# Parse command line arguments in case it have one #
####################################################

while [ "$1" != "${1##-}" ] ; do # loop over options
    case $1 in
       -v|--version)
                echo "refreshzone v0.4 by (c) Tuux from www.rtnp.org "
                echo "Galaxie is good for you ... "
                exit 1;
        ;;
        --verbose)
                VERBOSE=yes
        ;;

        --remote)
                REMOTE=yes
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
Usage: $0 [-v] [--help] [--tinydnsdir dir] [--primarydir dir] [--secondarydir dir] [--remote]"
Info :
    -v --version   : print the script version
    -h --help      : display it message
    --tinydnsdir   : tinydns root dir , where is store data and data.cdb
    --primarydir   : directory where store primary servers zone files
    --secondarydir : directory where store secondary servers zone files
    --verbose      : display output messages if not nothing is display on the output
    --remote       : less verbose ideal for script
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

##############################################
# Check if we have to crach before say hello #
##############################################

if [ ! -d "${TINYDNS_DIR}" ] ; then
    echo "tinydns root directory ${TINYDNS_DIR} not found"
    exit 1;
fi

if [ ! -f "${TINYDNS_DIR}/Makefile" ] ; then
    echo "Makefile not present in the tinydns root directory ${TINYDNS_DIR}"
    exit 1;
fi

#############################################################
# Create directories (if they don't exist) to store primary #
# and secondary dns zone templates.                             #
#############################################################

[ -d "$TINYDNS_ZONES_PRIMARY_DIR"   ] || mkdir -p "$TINYDNS_ZONES_PRIMARY_DIR"
[ -d "$TINYDNS_ZONES_SECONDARY_DIR" ] || mkdir -p "$TINYDNS_ZONES_SECONDARY_DIR"


#################################################################
# Concatenate all the primary and secondary zone templates together #
#################################################################

# Clean previous .data.tmp file
rm -f "${TINYDNS_DIR}/.data.tmp"

# Add primary file zone
[ -n "$VERBOSE" ] && echo "Primary zones:"
# shellcheck disable=SC2046
# shellcheck disable=SC2012
if [ $(ls -1A "${TINYDNS_ZONES_PRIMARY_DIR}"/ | wc -l) -gt 0 ] ; then
    echo "# Primary zone templates:" >> "${TINYDNS_DIR}/.data.tmp"
    for PRIMARY in "$TINYDNS_ZONES_PRIMARY_DIR"/*.data ; do
        # Generate serial
        # shellcheck disable=SC2006
        STAMP="`ls  --time-style=+%s -G  -o -g  "${PRIMARY}" | awk '{ print $4 }'`"
        [ -n "$VERBOSE" ] && echo "  ${PRIMARY} serial ${STAMP}"
        sed -r -e  "s/^(Z[^:]*:[^:]*:[^:]*)::(.*)$/\1:${STAMP}:\2/g" < "${PRIMARY}" > "$PRIMARY.tosend"
        echo "# Primary zone file $PRIMARY with timestamp of $STAMP" >> "${TINYDNS_DIR}/.data.tmp"
        chmod 640 "$PRIMARY.tosend"
        cat "$PRIMARY.tosend" >> "${TINYDNS_DIR}/.data.tmp"
    done
else
    [ -n "$VERBOSE" ] && echo "  no file zone ..."
fi

# Add secondary file zone
[ -n "$VERBOSE" ] && echo "Secondary zones:"
# shellcheck disable=SC2046
# shellcheck disable=SC2012
if [ $(ls -1A "${TINYDNS_ZONES_SECONDARY_DIR}"/ | wc -l) -gt 0 ] ; then
    echo "# Secondary zone templates:" >> "${TINYDNS_DIR}/.data.tmp"
    for file in "$TINYDNS_ZONES_SECONDARY_DIR"/*.data ; do
        [ -n "$VERBOSE" ] && echo "  $file"
        echo "# $file" >> "${TINYDNS_DIR}/.data.tmp"
	    cat "$file" >> "${TINYDNS_DIR}/.data.tmp"
    done
else
    [ -n "$VERBOSE" ] && echo "  no file zone ..."
fi

########################################################################
# If the master 'data' file is not present, or is different to the one #
# generated above, then use the new data from the concatenated zone    #
# templates, and compile it into a database.                               #
########################################################################

if [ ! -f "${TINYDNS_DIR}/data" ] || \
    ! ( diff -q "${TINYDNS_DIR}/.data.tmp" "${TINYDNS_DIR}/data" > /dev/null ) ; then
    [ -n "$VERBOSE" ] && echo "Building new tinydns database"
    [ -n "$REMOTE" ] && echo "Building new data file"
    mv "${TINYDNS_DIR}/.data.tmp" "${TINYDNS_DIR}/data"
        if [ -n "$VERBOSE" ] ; then
            make -C "${TINYDNS_DIR}"
        else
            make -C "${TINYDNS_DIR}" > /dev/null
        fi
else
    [ -n "$VERBOSE" ] && echo "No changes to zone data"
    [ -n "$REMOTE" ] && echo "No changes"
    exit 0;
fi

# Everything have a end