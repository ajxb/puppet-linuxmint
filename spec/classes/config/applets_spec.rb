require 'spec_helper'

describe 'linuxmint::config::applets' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure applets with defaults' do
        let :params do
          {
            group: 'testgroup',
            user:  'testuser'
          }
        end
        let :pre_condition do
          [
            'file { "/home/testuser/.local/share/cinnamon/applets/betterlock": ensure => present }',
            'file { "/home/testuser/.local/share/cinnamon/applets/workspace-grid@hernejj": ensure => present }'
          ]
        end

        it do
          should contain_gnome__gsettings('org.cinnamon_enabled-applets').with(
            schema: 'org.cinnamon',
            key:    'enabled-applets',
            value:  '"[\'panel1:right:1:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:right:3:notifications@cinnamon.org:6\', \'panel1:right:4:removable-drives@cinnamon.org:7\', \'panel1:right:5:user@cinnamon.org:8\', \'panel1:right:6:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:8:sound@cinnamon.org:13\', \'panel1:right:2:betterlock:17\', \'panel1:right:9:workspace-grid@hernejj:21\']"',
            user:   'testuser'
          )
        end
        it { should contain_gnome__gsettings('org.cinnamon_enabled-applets').that_requires('File[/home/testuser/.local/share/cinnamon/applets/betterlock]') }
        it { should contain_gnome__gsettings('org.cinnamon_enabled-applets').that_requires('File[/home/testuser/.local/share/cinnamon/applets/workspace-grid@hernejj]') }

        cinnamon_config_folders = %w[
          /home/testuser/.cinnamon
          /home/testuser/.cinnamon/configs
        ]

        cinnamon_config_folders.each do |folder|
          it do
            should contain_file(folder).with(
              ensure: 'directory',
              owner:  'testuser',
              group:  'testgroup',
              mode:   '0775'
            )
          end
        end

        applets = {
          'betterlock'                 => 'betterlock.json',
          'calendar@cinnamon.org'      => '12.json',
          'menu@cinnamon.org'          => '1.json',
          'notifications@cinnamon.org' => 'notifications@cinnamon.org.json',
          'power@cinnamon.org'         => 'power@cinnamon.org.json',
          'show-desktop@cinnamon.org'  => '2.json',
          'sound@cinnamon.org'         => 'sound@cinnamon.org.json',
          'user@cinnamon.org'          => '8.json',
          'workspace-grid@hernejj'     => 'workspace-grid@hernejj.json'
        }

        applets.each do |key, value|
          it do
            should contain_file("/home/testuser/.cinnamon/configs/#{key}").with(
              ensure: 'directory',
              owner:  'testuser',
              group:  'testgroup',
              mode:   '0775'
            )
          end
          cinnamon_config_folders.each do |folder|
            it { should contain_file("/home/testuser/.cinnamon/configs/#{key}").that_requires("File[#{folder}]") }
          end

          it do
            should contain_file("/home/testuser/.cinnamon/configs/#{key}/#{value}").with(
              ensure: 'file',
              source: "puppet:///modules/linuxmint/applets/#{key}/#{value}",
              owner:  'testuser',
              group:  'testgroup',
              mode:   '0664'
            )
          end
          it { should contain_file("/home/testuser/.cinnamon/configs/#{key}/#{value}").that_requires("File[/home/testuser/.cinnamon/configs/#{key}]") }
        end
      end
      context 'user param not set' do
        let :params do
          {
            group: 'testgroup'
          }
        end
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end
      context 'group param not set' do
        let :params do
          {
            user: 'testuser'
          }
        end
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'group' expects a String value, got Undef/)
        end
      end
    end
  end
end
