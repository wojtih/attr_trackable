class CreateAttrTrackableAttributeChange < ActiveRecord::Migration
  def self.up
    create_table :attr_trackable_attribute_changes do |t|
      t.string  :obj_type
      t.integer :obj_id
      t.string  :attrib
      t.text    :value_was
      t.text    :value_is
      t.string  :change_id
      t.integer :editor_id
      t.string  :editor_type

      t.timestamps
    end
  end

  def self.down
    drop_table :attribute_changes
  end
end
