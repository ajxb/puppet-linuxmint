# Class: linuxmint
#
# Manage configuration of Linux Mint
#
# @example Declaring the class
#   class { 'linuxmint':
#     group => 'thegroup',
#     user  => 'theuser',
#   }
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $group)
  assert_type(String[1], $user)

  #############################################################################
  # Create common folders
  #############################################################################
  file { "/home/${user}/.local/share/cinnamon":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0775',
    require => [
      User[$user],
      Group[$group],
    ],
  }

  file { $linuxmint::params::packages_root:
    ensure => 'directory',
    group  => 'root',
    mode   => '0755',
    owner  => 'root',
  }

  #############################################################################
  # Instatiate classes
  #############################################################################
  class { 'linuxmint::config::applets':
    group   => $group,
    user    => $user,
    require => [
      User[$user],
      Group[$group],
    ],
  }

  class { 'linuxmint::config::cinnamon':
    user    => $user,
    require => [
      User[$user],
    ],
  }

  class { 'linuxmint::config::gsettings':
    user    => $user,
    require => [
      User[$user],
    ],
  }

  class { 'linuxmint::config::mintwelcome':
    group   => $group,
    user    => $user,
    require => [
      User[$user],
      Group[$group],
    ],
  }

  class { 'linuxmint::config::nemo':
    user    => $user,
    require => [
      User[$user],
    ],
  }

  class { 'linuxmint::config::software_centre':
    user    => $user,
    require => [
      User[$user],
    ],
  }

  class { 'linuxmint::install::applets':
    group   => $group,
    user    => $user,
    require => [
      User[$user],
      Group[$group],
    ],
  }

  contain linuxmint::config::applets
  contain linuxmint::config::cinnamon
  contain linuxmint::config::gsettings
  contain linuxmint::config::mintwelcome
  contain linuxmint::config::nemo
  contain linuxmint::config::software_centre
  contain linuxmint::install::applets

  Class['linuxmint::install::applets']
  -> Class['linuxmint::config::applets']

  Class[
    'linuxmint::config::applets',
    'linuxmint::config::cinnamon',
    'linuxmint::config::mintwelcome',
    'linuxmint::config::nemo',
    'linuxmint::config::software_centre',
  ] -> Class['linuxmint::config::gsettings']
}
