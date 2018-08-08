#!/usr/local/bin/python
from os import environ
from subprocess import call

if "HTTPS_DOMAINS" in environ:
    for domain_host in environ["HTTPS_DOMAINS"].split(";"):
        parts = domain_host.split(":")
        print "Getting cert for {domain}".format(domain=parts[0])
        call(["certbot", "certonly", "--keep", ""--register-unsafely-without-email", "--webroot", "-w",  "/var/www", "-d", parts[0] ])
else:
    print "HTTPS_DOMAINS env not defined"