require 'delegate'
require 'yearbook/detected_object'
module Yearbook
  class << self
    def DetectionCollection(objs)
      Yearbook::DetectionCollection.new(objs)
    end
  end

  class DetectionCollection < SimpleDelegator
    # expects :parent_obj to be some kind of object with :width, :height
    def initialize(objs)
      a = Array(objs).map do |v|
        Yearbook::DetectedObject.new(v)
      end

      super(a)
    end

    def by_quality
      # this can't be good...
      self.__setobj__(self.sort{|x, y| y.quality <=> x.quality })
      self
    end

    # returns the object that seems most likely to be a good detection
    def best_candidate
      self.by_quality.first
    end

    alias_method :best, :best_candidate

    # # TODO: left to right, top to bottom
    # def lrtb
    #   self
    # end


  end
end

