# Class: profile::base::interfaces_netcf
#
#
class profile::base::interfaces_netcf {
  $network_params_netcf = hiera_hash (networkInterfacesNetcf, undef)
  unless empty($network_params_netcf) {
    create_resources(netcf_if, $network_params_netcf)
  }

# netcf-puppet needs netcf package
# The package has the same name on RedHat and debian
  ensure_resource('package', 'netcf', {'ensure' => 'installed'})
}
