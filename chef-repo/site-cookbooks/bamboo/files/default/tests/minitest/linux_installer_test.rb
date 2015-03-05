require File.expand_path('../support/helpers', __FILE__)

describe_recipe "bamboo::linux_installer" do
  include Helpers::Bamboo

  it 'has bamboo user' do
    user(node['bamboo']['user']).must_exist.with(:home, node['bamboo']['home_path'])
  end

  it 'starts Bamboo' do
    service("bamboo").must_be_running
  end

  it 'enables Bamboo' do
    service("bamboo").must_be_enabled
  end
  
end
