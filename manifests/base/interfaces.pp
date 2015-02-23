# Class: profile::base::interfaces
#
#
class profile::base::interfaces {
  $network_params = hiera_hash (networkInterfaces, undef)
  unless empty($network_params) {
    create_resources(network_if, $network_params)
  }

# netcf-puppet needs netcf package
# The package has the same name on RedHat and debian
  ensure_resource('package', 'netcf', {'ensure' => 'installed'})
}

