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

        it { should compile.with_all_deps }
        it { should contain_class('linuxmint') }
        it { should contain_class('linuxmint::config::cinnamon') }
        it { should contain_class('linuxmint::config::software_centre') }
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
