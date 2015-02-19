# Class: profile::base::vhosts
#
#
class profile::base::vhosts {
  $vhosts_params = hiera_hash (definedVhosts, undef)
  unless empty(vhosts_params) {
    create_resources(apache::vhost, $vhosts_params)
  }
}
