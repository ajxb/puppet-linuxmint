# linuxmint::install::applets
#
# Install Linux Mint Cinnamon applets
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::install::applets (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)
  assert_type(String[1], $group)

  file { "/home/${user}/.local/share/cinnamon/applets":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  vcsrepo { "${linuxmint::params::packages_root}/cinnamon-spices-applets":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/linuxmint/cinnamon-spices-applets.git',
    require  => File[$linuxmint::params::packages_root],
  }

  file { "/home/${user}/.local/share/cinnamon/applets/betterlock":
    ensure    => 'directory',
    group     => $group,
    mode      => '0700',
    owner     => $user,
    recurse   => true,
    source    => "file://${linuxmint::params::packages_root}/cinnamon-spices-applets/betterlock/files/betterlock",
    require   => File["/home/${user}/.local/share/cinnamon/applets"],
    subscribe => Vcsrepo["${linuxmint::params::packages_root}/cinnamon-spices-applets"],
  }

  file { "/home/${user}/.local/share/cinnamon/applets/workspace-grid@hernejj":
    ensure    => 'directory',
    group     => $group,
    mode      => '0700',
    owner     => $user,
    recurse   => true,
    source    => "file://${linuxmint::params::packages_root}/cinnamon-spices-applets/workspace-grid@hernejj/files/workspace-grid@hernejj",
    require   => File["/home/${user}/.local/share/cinnamon/applets"],
    subscribe => Vcsrepo["${linuxmint::params::packages_root}/cinnamon-spices-applets"],
  }
}
