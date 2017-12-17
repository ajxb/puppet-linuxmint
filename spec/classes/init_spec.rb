require 'spec_helper'

describe 'linuxmint' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      context 'init with defaults' do
        let :params do
          {
            user:  'testuser',
            group: 'testgroup'
          }
        end
        let :pre_condition do
          [
            'user  { "testuser":  ensure => present }',
            'group { "testgroup": ensure => present }'
          ]
        end

        it do
          should contain_file('/home/testuser/.local/share/cinnamon').with(
            ensure: 'directory',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0775'
          )
        end
        it { should contain_file('/home/testuser/.local/share/cinnamon').that_requires('Group[testgroup]') }
        it { should contain_file('/home/testuser/.local/share/cinnamon').that_requires('User[testuser]') }

        it do
          should contain_file('/opt/packages_puppet-linuxmint').with(
            ensure: 'directory',
            group:  'root',
            mode:   '0755',
            owner:  'root'
          )
        end

        it { should compile.with_all_deps }
        it { should contain_class('linuxmint') }
        it { should contain_class('linuxmint::config::applets') }
        it { should contain_class('linuxmint::config::applets').that_requires('Class[linuxmint::install::applets]') }
        it { should contain_class('linuxmint::config::applets').that_requires('Group[testgroup]') }
        it { should contain_class('linuxmint::config::applets').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::config::cinnamon') }
        it { should contain_class('linuxmint::config::cinnamon').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::config::gsettings') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('Class[linuxmint::config::applets]') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('Class[linuxmint::config::cinnamon]') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('Class[linuxmint::config::mintwelcome]') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('Class[linuxmint::config::nemo]') }
        it { should contain_class('linuxmint::config::gsettings').that_requires('Class[linuxmint::config::software_centre]') }
        it { should contain_class('linuxmint::config::mintwelcome') }
        it { should contain_class('linuxmint::config::mintwelcome').that_requires('Group[testgroup]') }
        it { should contain_class('linuxmint::config::mintwelcome').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::config::nemo') }
        it { should contain_class('linuxmint::config::nemo').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::config::software_centre') }
        it { should contain_class('linuxmint::config::software_centre').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::install::applets') }
        it { should contain_class('linuxmint::install::applets').that_requires('Group[testgroup]') }
        it { should contain_class('linuxmint::install::applets').that_requires('User[testuser]') }
        it { should contain_class('linuxmint::params') }
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

  context 'with unsupported operatingsystem' do
    let :facts do
      {
        operatingsystem: 'Unsupported OS'
      }
    end
    let :params do
      {
        user: 'testuser'
      }
    end

    it do
      expect do
        subject.call
      end.to raise_error(Puppet::Error, /Unsupported OS not supported/)
    end
  end
end
