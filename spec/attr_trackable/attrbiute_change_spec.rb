require 'spec_helper'
describe AttrTrackable::AttributeChange do
  
  Obj = Struct.new("Obj", :id, :editor)
  Editor ||= Struct.new("Editor", :id)
  
  describe "validations" do
    # it { should validate_presence_of(:obj_id) }
    # it { should validate_presence_of(:obj_type) }
    # it { should validate_presence_of(:attrib) }
    # it { should validate_presence_of(:change_id) }
  end

  describe "attributes" do    
    let(:editor) { Editor.new(1) }
    let(:obj) { Obj.new(1, nil) }
    
    it "should assign obj.id and obj_type when obj given" do
      subject.obj = obj
      subject.obj_id.should eq obj.id
      subject.obj_type.should be obj.class
    end

    it "should assign editor_id and editor_type if obj.editor present" do
      obj.editor = editor
      subject.obj = obj
      subject.editor_id.should eq editor.id
      subject.editor_type.should be editor.class
    end

    it "should assign value_was" do
      subject.value_was = "Foo"
      subject.value_was.should eq "Foo"
    end

    it "should assign value_is" do
      subject.value_is = "Bar"
      subject.value_is.should eq "Bar"
    end
  end
end

