require 'spec_helper'

describe 'linuxmint::config::nemo' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure nemo with defaults' do
        let :params do
          {
            user: 'testuser'
          }
        end
      end
    end
  end
end
