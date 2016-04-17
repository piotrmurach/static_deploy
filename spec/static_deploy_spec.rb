require 'spec_helper'

describe StaticDeploy do
  it 'should have a version number' do
    StaticDeploy::VERSION.should_not be_nil
  end
end
