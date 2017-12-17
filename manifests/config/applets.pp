# linuxmint::config::applets
#
# Configures Linux Mint Applets
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::config::applets (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)
  assert_type(String[1], $group)

  $cinnamon_config_folders = [
    "/home/${user}/.cinnamon",
    "/home/${user}/.cinnamon/configs",
  ]

  file { $cinnamon_config_folders:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  $applets = {
    'betterlock'                 => 'betterlock.json',
    'calendar@cinnamon.org'      => '12.json',
    'menu@cinnamon.org'          => '1.json',
    'notifications@cinnamon.org' => 'notifications@cinnamon.org.json',
    'power@cinnamon.org'         => 'power@cinnamon.org.json',
    'show-desktop@cinnamon.org'  => '2.json',
    'sound@cinnamon.org'         => 'sound@cinnamon.org.json',
    'user@cinnamon.org'          => '8.json',
    'workspace-grid@hernejj'     => 'workspace-grid@hernejj.json',
  }

  $applets.each |$key, $value| {
    file { "/home/${user}/.cinnamon/configs/${key}":
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0775',
      require => File[$cinnamon_config_folders],
    }

    file { "/home/${user}/.cinnamon/configs/${key}/${value}":
      ensure  => file,
      source  => "puppet:///modules/linuxmint/applets/${key}/${value}",
      owner   => $user,
      group   => $group,
      mode    => '0664',
      require => File["/home/${user}/.cinnamon/configs/${key}"],
    }
  }
}
