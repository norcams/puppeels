# Class: profile::base::lvm
#
#
class profile::base::lvm {
  include ::lvm

  create_resources(physical_volume, hiera_hash('physical_volume', {}))
  create_resources('::lvm::volume_group', hiera_hash('lvm::volume_group', {}))
  create_resources('::lvm::logical_volume', hiera_hash('lvm::logical_volume', {}))
  create_resources(filesystem, hiera_hash('filesystem', {}))
}
