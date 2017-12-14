# linuxmint::config::cinnamon
#
# Configures Linux Mint Cinnamon desktop
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::config::cinnamon (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)
  assert_type(String[1], $group)

  # Move the panel to the top of the screen
  gnome::gsettings { 'org.cinnamon_panels-enabled':
    schema => 'org.cinnamon',
    key    => 'panels-enabled',
    value  => '"[\'1:0:top\']"',
    user   => $user,
  }

  $cinnamon_applet_folders = [
    "/home/${user}/.local/share/cinnamon",
    "/home/${user}/.local/share/cinnamon/applets",
  ]

  file { $cinnamon_applet_folders:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  $packages_root = '/opt/packages_puppet-linuxmint'
  file { $packages_root:
    ensure => 'directory',
    group  => 'root',
    mode   => '0755',
    owner  => 'root',
  }

  # Clone cinnamon-spices-applets theme
  vcsrepo { "${packages_root}/cinnamon-spices-applets":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/linuxmint/cinnamon-spices-applets.git',
    require  => File[$packages_root],
  }

  file { "/home/${user}/.local/share/cinnamon/applets/betterlock":
    ensure    => 'directory',
    group     => $group,
    mode      => '0700',
    owner     => $user,
    recurse   => true,
    source    => "file://${packages_root}/cinnamon-spices-applets/betterlock/files/betterlock",
    subscribe => Vcsrepo["${packages_root}/cinnamon-spices-applets"],
  }

  file { "/home/${user}/.local/share/cinnamon/applets/workspace-grid@hernejj":
    ensure    => 'directory',
    group     => $group,
    mode      => '0700',
    owner     => $user,
    recurse   => true,
    source    => "file://${packages_root}/cinnamon-spices-applets/workspace-grid@hernejj/files/workspace-grid@hernejj",
    subscribe => Vcsrepo["${packages_root}/cinnamon-spices-applets"],
  }

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

  $cinnamon_config_folders = [
    "/home/${user}/.cinnamon",
    "/home/${user}/.cinnamon/configs",
    "/home/${user}/.cinnamon/configs/betterlock",
    "/home/${user}/.cinnamon/configs/calendar@cinnamon.org",
    "/home/${user}/.cinnamon/configs/menu@cinnamon",
    "/home/${user}/.cinnamon/configs/notifications@cinnamon",
    "/home/${user}/.cinnamon/configs/power@cinnamon",
    "/home/${user}/.cinnamon/configs/show-desktop@cinnamon",
    "/home/${user}/.cinnamon/configs/sound@cinnamon",
    "/home/${user}/.cinnamon/configs/user@cinnamon",
    "/home/${user}/.cinnamon/configs/workspace-grid@hernejj",
  ]

  file { $cinnamon_config_folders:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  # Configure betterlock applet
  file { "/home/${user}/.cinnamon/configs/betterlock/betterlock.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/betterlock/betterlock.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon calendar applet
  file { "/home/${user}/.cinnamon/configs/calendar@cinnamon.org/12.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/calendar@cinnamon.org/12.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon menu applet
  file { "/home/${user}/.cinnamon/configs/menu@cinnamon.org/1.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/menu@cinnamon.org/1.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon notifications applet
  file { "/home/${user}/.cinnamon/configs/notifications@cinnamon.org/notifications@cinnamon.org.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/notifications@cinnamon.org/notifications@cinnamon.org.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon power applet
  file { "/home/${user}/.cinnamon/configs/power@cinnamon.org/power@cinnamon.org.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/power@cinnamon.org/power@cinnamon.org.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon show-desktop applet
  file { "/home/${user}/.cinnamon/configs/show-desktop@cinnamon.org/2.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/show-desktop@cinnamon.org/2.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon sound applet
  file { "/home/${user}/.cinnamon/configs/sound@cinnamon.org/sound@cinnamon.org.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/sound@cinnamon.org/sound@cinnamon.org.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon user applet
  file { "/home/${user}/.cinnamon/configs/user@cinnamon.org/8.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/user@cinnamon.org/8.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }

  # Configure cinnamon workspace-grid applet
  file { "/home/${user}/.cinnamon/configs/workspace-grid@hernejj/workspace-grid@hernejj.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/workspace-grid@hernejj/workspace-grid@hernejj.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
    require => File[$cinnamon_config_folders],
  }
}
