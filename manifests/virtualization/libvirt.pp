# class profile::virtualization::libvirt
#
#

class profile::virtualization::libvirt {
  include ::libvirt

  $libvirt_networks = hiera_hash (libvirt_networks, undef)
  unless empty($libvirt_networks) {
    create_resources(libvirt::network, $libvirt_networks)
  }

  $libvirt_pool = hiera_hash (libvirt_pool, undef)
  unless empty($libvirt_pool) {
    create_resources(libvirt_pool, $libvirt_pool)
  }
}
