module Yearbook
  class DetectedObject

    # obj is something like a CvRect
    attr_reader :x, :y, :width, :height, :neighbors
    def initialize(obj, opts={})
      @x = obj.x
      @y = obj.y
      @width = obj.width
      @height = obj.height
      @neighbors = obj.respond_to?(:neighbors) ? obj.neighbors : 1
    end

    alias_method :w, :width
    alias_method :h, :height


    # returns: array in [x, y, w, h]
    def dim
      [x, y, w, h]
    end

    def px
      w * h
    end

    def quality
      (w * h + (neighbors * 10) * 0.001).round
    end


    def to_h
      %w(x y w h px neighbors quality).inject({}){|h, k| h[k] = self.send(k); h }
    end


    private


  end
end
