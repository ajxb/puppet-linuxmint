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

  # Configure panel applets
  gnome::gsettings { 'org.cinnamon_enabled-applets':
    schema  => 'org.cinnamon',
    key     => 'enabled-applets',
    value   => '"[\'panel1:right:1:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:right:3:notifications@cinnamon.org:6\', \'panel1:right:4:removable-drives@cinnamon.org:7\', \'panel1:right:5:user@cinnamon.org:8\', \'panel1:right:6:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:8:sound@cinnamon.org:13\', \'panel1:right:2:betterlock:17\', \'panel1:right:9:workspace-grid@hernejj:21\']"',
    user    => $user,
    require => [
      File["/home/${user}/.local/share/cinnamon/applets/betterlock"],
      File["/home/${user}/.local/share/cinnamon/applets/workspace-grid@hernejj"],
    ]
  }

  #############################################################################
  # Configure applets
  #############################################################################
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
