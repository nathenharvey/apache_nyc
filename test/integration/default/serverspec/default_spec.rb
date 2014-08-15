require 'serverspec'

include Serverspec::Helper::Exec

describe "apache" do
  it "is listening on port 80" do
    expect(port 80).to be_listening
  end

  it "is listening on port 81" do
    expect(port 81).to be_listening
  end
end
