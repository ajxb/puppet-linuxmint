require 'spec_helper'

describe 'linuxmint::config::mintwelcome' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure mintwelcome with defaults' do
        let :params do
          {
            group: 'testgroup',
            user:  'testuser'
          }
        end

        it do
          should contain_file('/home/testuser/.linuxmint').with(
            ensure: 'directory',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0700'
          )
        end

        it { should contain_file('/home/testuser/.linuxmint/mintwelcome/norun.flag').that_requires('File[/home/testuser/.linuxmint/mintwelcome]') }
        it do
          should contain_file('/home/testuser/.linuxmint/mintwelcome/norun.flag').with(
            ensure: 'file',
            content: '',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0700'
          )
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
