require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'apache' do
  it 'is installed' do
    expect(package 'httpd').to be_installed
  end

  it 'is running' do
    expect(service 'httpd').to be_running
  end

  it 'is enabled' do
    expect(service 'httpd').to be_enabled
  end

end

describe 'clowns website' do
  it 'is listening on port 80' do
    expect(port 80).to be_listening
  end

  it 'displays a custom home page' do
    expect(command 'curl localhost:80').to return_stdout(/clowns/)
  end
end

describe 'bears website' do
  it 'is listening on port 81' do
    expect(port 81).to be_listening
  end

  it 'displays a custom home page' do
    expect(command 'curl localhost:81').to return_stdout(/bears/)
  end
end
