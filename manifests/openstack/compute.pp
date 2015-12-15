class profile::openstack::compute {
  include ::nova
  include ::nova::network::neutron
}

# All compute hosts need this dhcp agent
# which should have been a dependeny for the
# calico-compute package. This may be fixed
# in the future.

package { 'networking-calico':
  ensure => installed,
}
