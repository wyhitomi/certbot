#!/bin/bash

ENV=${2:-dev}

function prop {
  grep "${2}" /domains/${ENV}.properties|cut -d'=' -f2
}

function webroot_cert_gen {
  certbot certonly --webroot -w $(prop 'web.root-path') -d $(prop 'domain.url') -d $(prop 'domain.www')
}

function standalone_cert_gen {
  certbot certonly --standalone -d $(prop 'domain.url') -d $(prop 'domain.www')
}

function renew {
  certbot renew --dry-run
}

function custom_cert_gen {
  # TODO
  echo "//TODO, custom_cert_gen not done yet"
}

function list_domains {
  # TODO
  echo "//TODO, list_domains not done yet"
}

case "$1" in
  webroot)
    echo "Creating webroot certificates for ${ENV}: "
    webroot_cert_gen
  ;;
  standalone)
    echo "Creating webroot certificates for ${ENV}: "
    standalone_cert_gen
  ;;
  renew)
    echo "Renew certificates for ${ENV}: "
    renew
  ;;
  custom)
    echo "Creating webroot certificates for ${ENV}: "
    custom_cert_gen
  ;;
  list)
    echo "Listing existing domains: "
    list_domains
  ;;
  *)
    echo "Usage: $0 (webroot|standalone|custom|list) domain"
  ;;
esac
