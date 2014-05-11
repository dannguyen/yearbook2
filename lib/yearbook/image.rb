require 'opencv'
require 'delegate'
require 'pathname'

module Yearbook
  class << self
    def Image(img)
      Yearbook::Image.new(img)
    end
  end

  class Image < SimpleDelegator
    def initialize(img)
      @item = img.is_a?(OpenCV::CvMat) ? img : OpenCV::CvMat.load(img)
      super(@item)
    end

    # args is DetectedObject with :dim OR an array [x,y,w,h]
    # returns a new Yearbook::Image object
    def cut_out(*args)
      s = self.sub_rect *(args[0].respond_to?(:dim) ? args[0].dim : args)

      Yearbook::Image(s)
    end

    def write(out_name)
      save(out_name)
    end

    def to_item
      @item
    end
  end



end
