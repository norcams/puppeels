# Class: profile::base::interfaces
#
#
class profile::base::interfaces {
  $network_params = hiera_hash (network_if, undef)
  unless empty($network_params) {
    create_resources(network_if, $network_params)
  }

  $network_params_netcf = hiera_hash (netcf_if, undef)
  unless empty($network_params_netcf) {
    create_resources(netcf_if, $network_params_netcf)
  }

# netcf-puppet needs netcf package
# The package has the same name on RedHat and debian
  ensure_resource('package', 'netcf', {'ensure' => 'installed'})
}

