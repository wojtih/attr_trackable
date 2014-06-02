require 'spec_helper'
require File.join('fixtures', 'dummy')

describe AttrTrackable do
  let(:dummy) { Dummy.new }

  describe "attributes" do    
    it "included creates geter for :editor" do
      dummy.should respond_to("editor")
    end

    it "included creates setter for :editor" do
      dummy.should respond_to("editor=")
    end

    it "should assign and return editor value" do
      dummy.editor = "Foo"
      dummy.editor.should eq "Foo"
    end
  end

  describe "after_update" do
    before(:each) { Dummy.attr_trackable :first_name, :last_name }
    let(:dummy) { Dummy.new gender: "Male", id: 1 }
    
    it "should not record not trackable attributes" do
      dummy.gender = "Female"
      dummy.save
      AttrTrackable::AttributeChange.count.should eq 0
    end
    
    it "should not record attribute that has not changed" do
      dummy.gender = "Male"
      dummy.save
      AttrTrackable::AttributeChange.count.should eq 0
    end

    it "should record attribute change" do
      dummy.first_name = "Baz"
      dummy.save
      AttrTrackable::AttributeChange.count.should eq 1
    end
    
    it "should record multiple attribute changes" do
      dummy.first_name, dummy.last_name = "Baz", "Foo"
      dummy.save
      AttrTrackable::AttributeChange.count.should eq 2
    end

    it "should record if attribute new value is nil" do
      dummy.first_name = "Baz"
      dummy.first_name = nil
      dummy.save
      AttrTrackable::AttributeChange.count.should eq 1
    end
  end

  describe "class methods" do
    before(:each) { Dummy.attr_trackable nil, except: nil }

    describe "#attr_trackable" do
      it "should return empty array if attr_trackable was not invoked" do
        Dummy.send("_attr_trackable").should eq []
      end

      it "should return array of assigned attributes" do
        Dummy.attr_trackable :foo, :bar, :baz
        Dummy.send("_attr_trackable").should eq [:foo, :bar, :baz]
      end

      it "should clear attr_trackable nil passed" do
        Dummy.attr_trackable nil
        Dummy.send("_attr_trackable").should eq []
      end

      it "should add all attrbiutes except default rejected if :all value given" do
        Dummy.attr_trackable :all
        Dummy.send("_attr_trackable").should eq [:first_name, :last_name, :gender]
      end

      it "should reject attributes from all if except option given" do
        Dummy.attr_trackable :all, except: [:id, :first_name, :last_name]
        Dummy.send("_attr_trackable").should eq [:gender, :created_at, :updated_at]
      end
    end
  end
end
