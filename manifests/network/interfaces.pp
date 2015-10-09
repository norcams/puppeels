# Class: profile::base::interfaces
#
#
class profile::network::interfaces {

  # Set up extra logical fact names for network facts
  include named_interfaces

  $network_params = hiera_hash (network_if, undef)

  # netcf-puppet needs netcf package
  # The package has the same name on RedHat and debian

  unless empty($network_params) {
    ensure_resource('package', 'netcf', {'ensure' => 'installed'})
    create_resources(network_if, $network_params)
  }

  $network_params_netcf = hiera_hash (netcf_if, undef)
  unless empty($network_params_netcf) {
    ensure_resource('package', 'netcf', {'ensure' => 'installed'})
    create_resources(netcf_if, $network_params_netcf)
  }

  # New example42 network module
  include ::network
}
