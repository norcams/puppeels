# Class: profile::base::lvm
#
#
class profile::base::lvm {
  include ::lvm

  create_resources(physical_volume, hiera_hash('profile::base::lvm::physical_volume', {}))
  create_resources(volume_group, hiera_hash('profile::base::lvm::volume_group', {}))
  create_resources(logical_volume, hiera_hash('profile::base::lvm::logical_volume', {}))
  create_resources(filesystem, hiera_hash('profile::base::lvm::filesystem', {}))
}
