class profile::openstack::network::calico(
  $manage_bird = true,
  $manage_etcd = true,
) {
  include ::calico

  if $manage_bird {
    include ::profile::network::bird
  }

  if $manage_etcd {
    include ::profile::application::etcd
  }
}
