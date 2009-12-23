require 'spec/spec_helper'

describe WP::Option do
  before do
    @option = WP::Option.first
  end

  it "updates" do
    @option.option_value = "cool"
    @option.save.should == true
    @option.option_value.should == "cool"
  end

  it "resets" do
    @option.reload
    @option.value.should_not == "cool"
    puts @option.value
  end

end
