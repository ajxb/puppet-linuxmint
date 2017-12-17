# linuxmint::params
#
# Handles the module default parameters
#
class linuxmint::params {
  $group = undef
  $user  = undef
  $packages_root = '/opt/packages_puppet-linuxmint'

  $gsettings = {
    'com.linuxmint.updates' => {
      'kernel-updates-are-safe'      => false,
      'kernel-updates-are-visible'   => true,
      'level1-is-safe'               => true,
      'level1-is-visible'            => true,
      'level2-is-safe'               => true,
      'level2-is-visible'            => true,
      'level3-is-safe'               => false,
      'level3-is-visible'            => true,
      'level4-is-safe'               => false,
      'level4-is-visible'            => true,
      'level5-is-safe'               => false,
      'level5-is-visible'            => false,
      'security-updates-are-safe'    => true,
      'security-updates-are-visible' => true,
      'show-policy-configuration'    => false,
    },
    'org.cinnamon' => {
      'alttab-switcher-enforce-primary-monitor' => true,
      'enabled-applets'                         => '"[\'panel1:right:1:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:right:3:notifications@cinnamon.org:6\', \'panel1:right:4:removable-drives@cinnamon.org:7\', \'panel1:right:5:user@cinnamon.org:8\', \'panel1:right:6:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:8:sound@cinnamon.org:13\', \'panel1:right:2:betterlock:17\', \'panel1:right:9:workspace-grid@hernejj:21\']"',
      'enable-looking-glass-logs'               => false,
      'next-applet-id'                          => 22,
      'panels-enabled'                          => '"[\'1:0:top\']"',
    },
    'org.cinnamon.desktop.default-applications.terminal' => {
      'exec' => '\'gnome-terminal --command "bash --login"\'',
    },
    'org.cinnamon.desktop.keybindings' => {
      'looking-glass-keybinding'   => '"@as []"',
    },
    'org.cinnamon.desktop.keybindings.media-keys' => {
      'screensaver'   => '"[\'<Primary><Alt>l\', \'XF86ScreenSaver\', \'<Super>l\']"',
    },
    'org.cinnamon.desktop.media-handling' => {
      'autorun-never'   => true,
    },
    'org.cinnamon.desktop.screensaver' => {
      'screensaver-name'  => '"xscreensaver@cinnamon.org"',
      'xscreensaver-hack' => '"fireworkx"',
    },
    'org.cinnamon.desktop.sound' => {
      'volume-sound-enabled' => false,
    },
    'org.cinnamon.settings-daemon.peripherals.mouse' => {
      'middle-button-enabled' => false,
      'double-click'          => 1000,
    },
    'org.cinnamon.settings-daemon.peripherals.touchpad' => {
      'clickpad-click'       => 2,
      'horizontal-scrolling' => true,
      'custom-acceleration'  => true,
      'custom-threshold'     => true,
      'motion-acceleration'  => 8.25,
    },
    'org.cinnamon.settings-daemon.plugins.power' => {
      'button-power'       => '"shutdown"',
    },
    'org.cinnamon.sounds' => {
      'login-enabled'  => false,
      'logout-enabled' => false,
      'switch-enabled' => false,
      'tile-enabled'   => false,
      'plug-enabled'   => false,
      'unplug-enabled' => false,
    },
    'org.gnome.nm-applet' => {
      'disable-connected-notifications' => true,
    },
    'org.nemo.desktop' => {
      'trash-icon-visible'   => true,
      'network-icon-visible' => true,
    },
  }

  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
