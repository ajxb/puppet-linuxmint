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

  $schemas = {
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
  }

  $schemas.each |$schema, $settings| {
    $settings.each |$key, $value| {
      gnome::gsettings { "${schema}_${key}":
        schema => $schema,
        key    => $key,
        value  => $value,
        user   => $user,
      }
    }
  }
}
