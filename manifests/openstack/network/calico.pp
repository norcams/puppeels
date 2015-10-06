class profile::openstack::network::calico(
  $manage_bird     = true,
  $manage_etcd     = true,
  $manage_firewall = true,
  $firewall_extras = {},
) {
  include ::calico

  if $manage_bird {
    include ::profile::network::bird
  }

  if $manage_etcd {
    include ::profile::application::etcd
  }

  # Define a wrapper to avoid duplicating config per interface
  define calico_interface {
    $iniface_name = regsubst($name, '_', '.')
    profile::firewall::rule { "010 calico - accept all to ${name}":
        proto   => 'all',
        iniface => $iniface_name,
        extras  => $firewall_extras,
    }
  }

  if $manage_firewall {
    profile::firewall::rule { '910 calico - allow DHCP requests':
      proto  => 'udp',
      port   => '67',
      extras => {
        sport => '68',
      }
    }
    # Per https://github.com/projectcalico/calico/blob/master/rpm/calico.spec#L43-L48
    profile::firewall::rule { '911 calico - mangle checksum for dhcp':
      proto => 'udp',
      chain => 'POSTROUTING',
      port  => '68',
      extras => {
        checksum_fill => 'true',
        table         => 'mangle',
        jump          => 'CHECKSUM',
        action        => undef,
        state         => undef,
      },
    }
    # Depend on $transport_interfaces fact
    calico_interface { $::transport_interfaces: }
  }
}
