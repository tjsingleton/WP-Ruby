require 'spec_helper'

describe WP::Utility do
  include WP::Utility

  context 'is_serialized' do
    it 'only tries strings' do
       is_serialized?(1).should be_false
    end

    it 'recognizes null' do
      is_serialized?('N').should be_true
    end

    it 'recognizes integers' do
      is_serialized?('i:1;').should be_true
    end

    it 'recognizes doubles' do
      is_serialized?('i:1.1;').should be_true
    end

    it 'recognizes true' do
      is_serialized?('b:1;').should be_true
    end

    it 'recognizes false' do
      is_serialized?('b:0;').should be_true
    end

    it 'recognizes string' do
      is_serialized?('s:5:"Hello";').should be_true
    end

    it 'recognizes an array' do
      is_serialized?('a:1:{i:1;i:2}').should be_true
    end

    # TODO Failures.
  end

  context "php_serialize delegators" do
    it "delegates serialize to PHP" do
      PHP.should_receive(:serialize)
      serialize(1)
    end

    it "delegates unserialize to PHP" do
      PHP.should_receive(:unserialize)
      unserialize(1)
    end
  end
end
