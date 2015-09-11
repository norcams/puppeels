class profile::openstack::network::calico(
  $manage_bird = true,
  $manage_etcd = true,
) {
  include profile::openstack::network

  if $manage_brid {
    include ::profile::network::bird
  }

  if $manage_etcd {
    include ::profile::application::etcd
  }
}
