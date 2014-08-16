require 'chefspec'
require 'chefspec/deprecations'

# at_exit { ChefSpec::Coverage.report! }

describe 'apache::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['apache']['sites']['lions'] = { 'port' => 82 }
    end.converge(described_recipe)
  end

  it 'installs apache' do
    expect(chef_run).to install_package('httpd')
  end

  it 'starts apache' do
    expect(chef_run).to start_service('httpd')
  end

  it 'enables apache' do
    expect(chef_run).to enable_service('httpd')
  end

  it 'creates a default home page' do
    expect(chef_run).to render_file('/var/www/html/index.html').with_content(/Hello/)
  end

  it 'creates a virtual host configuration for clowns' do
    expect(chef_run).to render_file('/etc/httpd/conf.d/clowns.conf').with_content('VirtualHost')
  end

  it 'creates a document root for clowns' do
    expect(chef_run).to create_directory('/srv/apache/clowns')
  end

  it 'creates a home page for clowns' do
    expect(chef_run).to render_file('/srv/apache/clowns/index.html').with_content('clowns')
  end

  it 'creates a virtual host configuration for bears' do
    expect(chef_run).to render_file('/etc/httpd/conf.d/bears.conf').with_content('VirtualHost')
  end

  it 'creates a document root for bears' do
    expect(chef_run).to create_directory('/srv/apache/bears')
  end

  it 'creates a home page for bears' do
    expect(chef_run).to render_file('/srv/apache/bears/index.html').with_content('bears')
  end

  it 'creates a virtual host configuration for lions' do
    expect(chef_run).to render_file('/etc/httpd/conf.d/lions.conf').with_content('VirtualHost')
  end

  it 'creates a document root for lions' do
    expect(chef_run).to create_directory('/srv/apache/lions')
  end

  it 'creates a home page for lions' do
    expect(chef_run).to render_file('/srv/apache/lions/index.html').with_content('lions')
  end
end
