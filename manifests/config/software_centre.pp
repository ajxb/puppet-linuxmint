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

  gnome::gsettings { 'com.linuxmint.updates_show-policy-configuration':
    schema => 'com.linuxmint.updates',
    key    => 'show-policy-configuration',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level3-is-visible':
    schema => 'com.linuxmint.updates',
    key    => 'level3-is-visible',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level4-is-visible':
    schema => 'com.linuxmint.updates',
    key    => 'level4-is-visible',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level3-is-safe':
    schema => 'com.linuxmint.updates',
    key    => 'level3-is-safe',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level4-is-safe':
    schema => 'com.linuxmint.updates',
    key    => 'level4-is-safe',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_security-updates-are-safe':
    schema => 'com.linuxmint.updates',
    key    => 'security-updates-are-safe',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_kernel-updates-are-safe':
    schema => 'com.linuxmint.updates',
    key    => 'kernel-updates-are-safe',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level1-is-visible':
    schema => 'com.linuxmint.updates',
    key    => 'level1-is-visible',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level2-is-visible':
    schema => 'com.linuxmint.updates',
    key    => 'level2-is-visible',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level5-is-visible':
    schema => 'com.linuxmint.updates',
    key    => 'level5-is-visible',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level1-is-safe':
    schema => 'com.linuxmint.updates',
    key    => 'level1-is-safe',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level2-is-safe':
    schema => 'com.linuxmint.updates',
    key    => 'level2-is-safe',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_level5-is-safe':
    schema => 'com.linuxmint.updates',
    key    => 'level5-is-safe',
    value  => false,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_security-updates-are-visible':
    schema => 'com.linuxmint.updates',
    key    => 'security-updates-are-visible',
    value  => true,
    user   => $user,
  }

  gnome::gsettings { 'com.linuxmint.updates_kernel-updates-are-visible':
    schema => 'com.linuxmint.updates',
    key    => 'kernel-updates-are-visible',
    value  => true,
    user   => $user,
  }
}
