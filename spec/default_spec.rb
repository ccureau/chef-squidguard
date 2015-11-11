require 'chefspec'

describe 'squidguard::default' do
  let :chef_run do
    ChefSpec::SoloRunner.new(platform: 'debian', version: '8.2')
  end
end

it "should install the squidguard binary" do
  chef_run.converge(described_recipe)
  expect(chef_runner).to install_package('squidguard')
end
