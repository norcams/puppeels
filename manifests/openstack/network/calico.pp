class profile::openstack::network::calico(
  $manage_bird = true,
  $manage_etcd = true,
) {
  include ::calico
  include ::profile::openstack::network::dhcp
  include ::profile::openstack::network::metadata

  if $manage_bird {
    include ::profile::network::bird
  }

  if $manage_etcd {
    include ::profile::application::etcd
  }
}
