# = Class: profile::application::sslcert
#
# Author: Name Surname <name.surname@mail.com>
class profile::application::sslcert (
    $create_new     = false,
) {

  contain ::openssl

  if $create_new {
    openssl::certificate::x509 { "$fqdn":
      country	   => 'NO',
      organization => 'private.org',
      commonname   => $fqdn,
      owner        => apache,
    }
  }
}