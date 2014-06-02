class Dummy
  extend ActiveModel::Callbacks
  include ActiveModel::Dirty
  
  @@objects = []

  attr_accessor :id, :first_name, :last_name, :gender, :valid, :new_record

  define_attribute_methods [:first_name, :last_name, :gender]

  define_model_callbacks :update

  include AttrTrackable

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @id = @@objects.size + 1
    @@objects << self
  end

  def self.column_names
    %w(id first_name last_name gender created_at updated_at)
  end

  def save
    run_callbacks :update do
      valid.nil? || valid
    end
  end

  def first_name=(val)
    @first_name_was = @first_name if val != @first_name
    first_name_will_change! unless val == @first_name
    @first_name = val
  end

  def gender=(val)
    @gender_was = @gender if val != @gender
    gender_will_change! unless val == @gender
    @gender = val
  end

  def last_name=(val)
    @last_name_was = @last_name if val != @last_name
    last_name_will_change! unless val == @last_name
    @last_name = val
  end

  def changes
    result = {}
    result["gender"] = [ @gender_was, @gender ] if gender_changed?
    result["first_name"] = [ @first_name_was, @first_name ] if first_name_changed?
    result["last_name"] = [ @last_name_was, @last_name ] if last_name_changed?
    result
  end
end
