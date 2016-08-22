require 'spec_helper'

describe 'Metaflows agent' do
  it 'is running metaflows' do
    expect(service('metaflows')).to be_running
  end

  it 'redirects stderr to svlogd' do
    file('/etc/service/metaflows/run') do
      expect(its(:content) { should include('exec 2>&1') })
    end
  end

end

