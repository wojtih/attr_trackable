class AttrTrackable::AttributeChange < ActiveRecord::Base
  def self.table_name_prefix
    'attr_trackable_'
  end

  validates :obj_type, :obj_id, :attrib, :change_id, presence: true

  def obj_type
    if val = read_attribute(:obj_type)
      val.constantize
    end 
  end

  def obj
    if obj_type && obj_id
      obj_type.find_by_id obj_id
    end
  end

  def editor_type
    if val = read_attribute(:editor_type)
      val.constantize
    end 
  end

  def editor
    if editor_type && editor_id
      editor_type.find_by_id editor_id
    end
  end

  def obj=(val)
    self.obj_id = val.id
    self.obj_type = val.class.name
    self.editor = val.editor if val.editor
  end

  def editor=(val)
    self.editor_id = val.id
    self.editor_type = val.class.name
  end

  def value_is=(val)
    write_attribute :value_is, serialize(val)
  end

  def value_is
    deserialize read_attribute(:value_is)
  end

  def value_was=(val)
    write_attribute :value_was, serialize(val)
  end

  def value_was
    deserialize read_attribute(:value_was)
  end


  private

    def serialize(val)
      Base64.encode64(Marshal.dump(val))
    end

    def deserialize(val)
      Marshal.load(Base64.decode64(val))
    end
end