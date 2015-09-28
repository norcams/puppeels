class profile::openstack::network(
  $l2_driver = 'ovs',
  $plugin    = 'ml2',
  $manage_firewall = true,
  $firewall_extras = {},
){
  include ::neutron
  include "::neutron::plugins::${plugin}"

  if $plugin == 'ml2' {
    include "::neutron::agents::ml2::${l2_driver}"
  } else {
    include "::neutron::agents::${plugin}"
  }

  if $manage_firewall {
    profile::firewall::rule{ '223 tunnelling accept gre':
      port   => undef,
      proto  => 'gre',
      extras => $firewall_extras,
    }
  }

}
