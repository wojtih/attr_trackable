class AttrTrackable::Performer
  
  def initialize(attribs)
    @obj = attribs[:obj]
    @attr_names = attribs[:attr_names]
    @change_id = "#{@obj.object_id}#{Time.now.to_i}"
  end

  def perform!
    @attr_names.each do |attr_name|
      perform_one(attr_name)
    end
  end


  private

    def perform_one(attr_name)
      AttrTrackable::AttributeChange.create! do |ac|
        ac.obj         = @obj
        ac.attrib      = attr_name
        ac.value_is    = @obj.changes[attr_name].last
        ac.value_was   = @obj.changes[attr_name].first
        ac.change_id   = @change_id        
      end
    end
end