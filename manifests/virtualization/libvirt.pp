#
# class profile::virtualization::libvirt
#
class profile::virtualization::libvirt(
  $manage_firewall = false,
  $firewall_extras = {
    'tcp' => {},
    'tls' => {},
  },
) {
  include ::libvirt

  $libvirt_networks = hiera_hash (libvirt_networks, undef)
  unless empty($libvirt_networks) {
    create_resources(libvirt::network, $libvirt_networks)
  }

  $libvirt_pool = hiera_hash (libvirt_pool, undef)
  unless empty($libvirt_pool) {
    create_resources(libvirt_pool, $libvirt_pool)
  }

  if $manage_firewall {
    profile::firewall::rule { '180 libvirt-tcp accept tcp':
      port   => 16509,
      extras => $firewall_extras['tcp']
    }

    profile::firewall::rule { '181 libvirt-tls accept tcp':
      port   => 16514,
      extras => $firewall_extras['tls']
    }
  }
}
