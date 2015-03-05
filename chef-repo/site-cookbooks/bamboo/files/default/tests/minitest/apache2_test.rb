require File.expand_path('../support/helpers', __FILE__)

describe_recipe "bamboo::apache2" do
  include Helpers::Bamboo

  it 'has apache VirtualHost' do
  	file("#{node['apache']['dir']}/sites-available/#{node['bamboo']['apache2']['virtual_host_name']}.conf").must_exist
  end

  it 'starts apache' do
    apache_service.must_be_running
  end

  it 'enables apache' do
    apache_service.must_be_enabled
  end

end
