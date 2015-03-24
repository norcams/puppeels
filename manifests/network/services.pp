#
class profile::network::services(
  $manage_dhcp = false,
  $manage_nat  = false,
) {
  $networks = hiera_hash('networks', false)

  if $networks {
    $subnet = $networks[$location]['subnet']
    $dhcp   = $networks[$location]['dhcp']
    $nat    = $networks[$location]['nat']

    if $manage_dhcp {
      include dnsmasq
      dnsmasq::conf { 'disable-dns': prio => '01', content => "port=0\n" }

      # Define dhcp ranges per subnet
      $dhcp_keys = keys($dhcp)
      $dhcp_resources = prefix($dhcp_keys, 'dhcp_')
      profile::network::service::dhcp { $dhcp_resources:
        subnet => $subnet,
        dhcp => $dhcp,
      }
    }

    if $manage_nat {
      # TODO: Add iptables nat rules
    }

  } else {
    warning("hiera returns no data for 'networks', so we're noop!")
  }
}
