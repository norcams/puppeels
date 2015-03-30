#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'theforeman/foreman'
#   mod 'theforeman/foremam_proxy'
#   mod 'theforeman/puppet'
#   mod 'theforeman/tftp'
#   mod 'zack/r10k'
#
class profile::application::foreman(
  $manage_eyaml = false
) {

  include ::r10k
  include ::puppet
  include ::foreman
  include ::foreman_proxy

  if $manage_eyaml {
    include ::hiera_eyaml
  }
}
