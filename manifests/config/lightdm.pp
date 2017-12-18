# linuxmint::config::lightdm
#
# Configures Linux Mint lightdm
#
class linuxmint::config::lightdm () inherits linuxmint::params {
  file { '/etc/lightdm/lightdm.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/linuxmint/lightdm/lightdm.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/lightdm/slick-greeter.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/linuxmint/lightdm/slick-greeter.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
