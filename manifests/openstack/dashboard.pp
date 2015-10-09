class profile::openstack::dashboard(
  $manage_ssl_cert = true,
  $manage_firewall = true,
  $firewall_extras = {},
) {
  include ::horizon

  if $manage_ssl_cert {
    include profile::application::sslcert
    Class ['horizon'] ->
    Class ['profile::application::sslcert'] ->
    Openssl::Certificate::X509
  }

  if $manage_firewall {
    profile::firewall::rule { '235 openstack-dashboard accept tcp':
      port    => [80,443],
      iniface => $interface_service1,
      source  => '129.177.0.0/16',
      extras  => $firewall_extras
    }
  }
}
