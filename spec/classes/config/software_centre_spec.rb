require 'spec_helper'

describe 'linuxmint::config::software_centre' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure software centre with defaults' do
        it do
          should contain_file('/etc/apt/sources.list.d/official-package-repositories.list').with(
            ensure: 'file',
            source: 'puppet:///modules/linuxmint/official-package-repositories.list',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
        it do
          should contain_exec('apt-update').with(
            command: '/usr/bin/apt-get update'
          ).that_subscribes_to('File[/etc/apt/sources.list.d/official-package-repositories.list]')
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_show-policy-configuration').with(
            schema: 'com.linuxmint.updates',
            key:    'show-policy-configuration',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level3-is-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'level3-is-visible',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level4-is-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'level4-is-visible',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level3-is-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'level3-is-safe',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level4-is-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'level4-is-safe',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_security-updates-are-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'security-updates-are-safe',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_kernel-updates-are-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'kernel-updates-are-safe',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level1-is-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'level1-is-visible',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level2-is-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'level2-is-visible',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level5-is-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'level5-is-visible',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level1-is-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'level1-is-safe',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level2-is-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'level2-is-safe',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_level5-is-safe').with(
            schema: 'com.linuxmint.updates',
            key:    'level5-is-safe',
            value:  'false'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_security-updates-are-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'security-updates-are-visible',
            value:  'true'
          )
        end
        it do
          should contain_gnome__gsettings('com.linuxmint.updates_kernel-updates-are-visible').with(
            schema: 'com.linuxmint.updates',
            key:    'kernel-updates-are-visible',
            value:  'true'
          )
        end
      end
    end
  end
end
