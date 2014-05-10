require 'yearbook/detected_object'
module Yearbook
  class DetectionCollection < Array

    # expects :parent_obj to be some kind of object with :width, :height
    def initialize(objs, parent_obj=nil)
      opts = parent_obj.nil? ? nil : {source_width: parent_obj.width, source_height: parent_obj.height}

      a = Array(objs).map do |v|
        Yearbook::DetectedObject.new(v, opts)
      end

      super(a)
    end

    def by_quality
      self.sort{|x, y| y.quality <=> x.quality }
    end

    # returns the object that seems most likely to be a good detection
    def best_candidate
      by_quality.first
    end

    # TODO: left to right, top to bottom
    def lrtb
      self
    end




    alias_method :best, :best_candidate

  end
end


def DetectionCollection(*args)
  Yearbook::DetectionCollection.new(*args)
end
