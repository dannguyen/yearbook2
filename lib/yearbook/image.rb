require 'opencv'
require 'delegate'
require 'pathname'

module Yearbook
  class Image < SimpleDelegator

    attr_reader :item
    attr_reader :pathname, :filename, :dirname, :basename, :extname

    def initialize(a, b = nil)
      if a.is_a?(String)
        @pathname = Pathname.new(a)
        @item = OpenCV::CvMat.load(@pathname.to_s)
      else
        # a is an image thingy, b is the filename
        @item = a
        @pathname = Pathname.new(b) unless b.nil?
      end

      super(@item)

      if @pathname
        @filename = pathname.to_s
        @dirname = pathname.dirname.to_s
        @basename = pathname.basename.to_s
        @extname = pathname.extname
      end
    end

    # args is DetectedObject with :dim OR an array [x,y,w,h]
    # returns a new Yearbook::Image object
    def cut_out(*args)
      Yearbook::Image.new self.sub_rect *(args[0].respond_to?(:dim) ? args[0].dim : args)
    end

    def print(out_name)
      save(out_name)
    end

    def to_item
      self.item
    end
  end



end
