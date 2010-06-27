require 'spec/spec_helper'

describe WP::Option do
  it "updates" do
    @option = WP::Option.new(:option_name => "Name", :option_value => "Test")
    @option.save.should == true
  end

  it "resets" do
    WP::Option.first(:option_name => "Name").should be_nil
  end
end
