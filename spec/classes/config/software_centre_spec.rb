require 'spec_helper'

describe 'linuxmint::config::software_centre' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure software centre with defaults' do
        let :params do
          {
            user: 'testuser'
          }
        end
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
      end

      context 'user param not set' do
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end
    end
  end
end
