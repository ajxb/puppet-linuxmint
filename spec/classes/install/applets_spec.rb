require 'spec_helper'

describe 'linuxmint::install::applets' do
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
            'file { "/opt/packages_puppet-linuxmint": ensure => present }'
          ]
        end

        it do
          should contain_file('/home/testuser/.local/share/cinnamon/applets').with(
            ensure: 'directory',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0775'
          )
        end

        it do
          should contain_vcsrepo('/opt/packages_puppet-linuxmint/cinnamon-spices-applets').with(
            ensure:   'present',
            provider: 'git',
            source:   'https://github.com/linuxmint/cinnamon-spices-applets.git'
          )
        end
        it { should contain_vcsrepo('/opt/packages_puppet-linuxmint/cinnamon-spices-applets').that_requires('File[/opt/packages_puppet-linuxmint]') }

        it do
          should contain_file('/home/testuser/.local/share/cinnamon/applets/betterlock').with(
            ensure: 'directory',
            group:  'testgroup',
            mode:   '0700',
            owner:   'testuser',
            recurse: true,
            source: 'file:///opt/packages_puppet-linuxmint/cinnamon-spices-applets/betterlock/files/betterlock'
          )
        end
        it { should contain_file('/home/testuser/.local/share/cinnamon/applets/betterlock').that_requires('File[/home/testuser/.local/share/cinnamon/applets]') }
        it { should contain_file('/home/testuser/.local/share/cinnamon/applets/betterlock').that_subscribes_to('Vcsrepo[/opt/packages_puppet-linuxmint/cinnamon-spices-applets]') }

        it do
          should contain_file('/home/testuser/.local/share/cinnamon/applets/workspace-grid@hernejj').with(
            ensure: 'directory',
            group:  'testgroup',
            mode:   '0700',
            owner:   'testuser',
            recurse: true,
            source: 'file:///opt/packages_puppet-linuxmint/cinnamon-spices-applets/workspace-grid@hernejj/files/workspace-grid@hernejj'
          )
        end
        it { should contain_file('/home/testuser/.local/share/cinnamon/applets/workspace-grid@hernejj').that_requires('File[/home/testuser/.local/share/cinnamon/applets]') }
        it { should contain_file('/home/testuser/.local/share/cinnamon/applets/workspace-grid@hernejj').that_subscribes_to('Vcsrepo[/opt/packages_puppet-linuxmint/cinnamon-spices-applets]') }
      end
    end
  end
end
