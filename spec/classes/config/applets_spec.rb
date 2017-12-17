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
    end
  end
end
