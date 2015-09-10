#
# class profile::virtualization::qemu
#
class profile::virtualization::qemu(
  $profile = 'default'
) {

  if $profile != 'default' {
    include "::profile::virtualization::qemu::${profile}"
  }

}
