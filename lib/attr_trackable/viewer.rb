class AttrTrackable::Viewer
  attr_reader :editor, :value_was, :value_is, :attr_name, :modified_at
  
  def initialize(args)
    @obj = args[:obj]
    @attr_names = args[:attr_names]
  end

  def fetch
    AttrTrackable::AttributeChange.where(obj_id: @obj.id, attrib: @attr_names).order("created_at DESC")
  end
end