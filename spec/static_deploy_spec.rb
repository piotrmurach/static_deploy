require 'spec_helper'

RSpec.describe StaticDeploy do
  it 'has a version number' do
    expect(StaticDeploy::VERSION).to_not be_nil
  end
end
