require 'active_record'
require "attr_trackable/version"
require "attr_trackable/attribute_change"
require "attr_trackable/performer"
require "attr_trackable/viewer"

module AttrTrackable
  extend ActiveSupport::Concern

  included do
    attr_accessor :editor
    class_attribute :_trackable_attributes
    after_update :store_trackable_attr_changes

    def changes_history(*attr_names)
      AttributeChanges::Viewer.new(obj: self, attr_names: attr_names).fetch
    end
  
    private

      def store_trackable_attr_changes
        if changed? && changed_trackable_attributes_names.any?
          AttrTrackable::Performer.new(obj: self, attr_names: changed_trackable_attributes_names).perform!
        end
      end

      def changed_trackable_attributes_names
        self.class._trackable_attributes.map(&:to_s) & changes.keys
      end
  end

  module ClassMethods
    def attr_trackable(*attribs)
      opts = attribs.extract_options!
      
      self._trackable_attributes = if attribs.first == :all
        column_names.map(&:to_sym) - (opts[:except].presence || _rejected_by_default)
      else
        attribs.compact
      end
    end


    private

      def _attr_trackable
        self._trackable_attributes ||= []
      end

      def _rejected_by_default
        [:id, :created_at, :updated_at]
      end
  end
end

class ActiveRecord::Base
	include AttrTrackable
end
