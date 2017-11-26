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

  # Configure panel applets
  gnome::gsettings { 'org.cinnamon_enabled-applets':
    schema => 'org.cinnamon',
    key    => 'enabled-applets',
    value  => '"[\'panel1:right:0:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:left:2:panel-launchers@cinnamon.org:3\', \'panel1:left:3:window-list@cinnamon.org:4\', \'panel1:right:1:keyboard@cinnamon.org:5\', \'panel1:right:2:notifications@cinnamon.org:6\', \'panel1:right:3:removable-drives@cinnamon.org:7\', \'panel1:right:4:user@cinnamon.org:8\', \'panel1:right:5:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:9:sound@cinnamon.org:13\']"',
    user   => $user,
  }

  # Configure cinnamon calendar applet
  file { "/home/${user}/.cinnamon/configs/calendar@cinnamon.org/12.json":
    ensure => file,
    source => 'puppet:///modules/linuxmint/cinnamon/calendar@cinnamon.org/12.json',
    owner  => $user,
    group  => $group,
    mode   => '0664',
  }
}
