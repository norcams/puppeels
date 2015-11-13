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

  # Configure 82599ES SFP+ interface module options, if present
  if $::lspci_has['intel82599sfp'] and "ixgbe" in $::kernel_modules {
    include ::kmod
    # Set SFP option in /etc/modprobe.d/ixgbe.conf
    kmod::option { 'allow all SFPs':
      module  => 'ixgbe',
      option  => 'allow_unsupported_sfp',
      value   => '1',
    }
    # Set option in grub2
    kernel_parameter { "ixgbe.allow_unsupported_sfp":
      ensure => present,
      value  => "1",
    }
  }

}
