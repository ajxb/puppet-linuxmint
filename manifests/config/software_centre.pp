# linuxmint::config::software_centre
#
# Configures Linux Mint software centre
#
# @param [String] user Mandatory parameter that specifies the user to configure
class linuxmint::config::software_centre (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  # Software Centre / Updates configuration
  file { '/etc/apt/sources.list.d/official-package-repositories.list':
    ensure => file,
    source => 'puppet:///modules/linuxmint/official-package-repositories.list',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  exec { 'apt-update':
    command   => '/usr/bin/apt-get update',
    subscribe => File['/etc/apt/sources.list.d/official-package-repositories.list'],
  }
}
