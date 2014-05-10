module Yearbook
  class DetectedObject

    # obj is something like a CvRect
    attr_reader :x, :y, :width, :height, :neighbors, :source_height, :source_width
    def initialize(obj, opts={})
      @x = obj.x
      @y = obj.y
      @width = obj.width
      @height = obj.height
      @neighbors = obj.respond_to?(:neighbors) ? obj.neighbors : 1

      @source_width = opts[:source_width]
      @source_height = opts[:source_height]

      @dim_mag = calculate_dimensional_magnitude
    end

    def to_h
      %w(x y w h px neighbors quality).inject({}){|h, k| h[k] = self.send(k); h }
    end

    # returns: array in [x, y, w, h]
    def dim
      [x, y, w, h]
    end

    # [00x]x[00y]-[w]x[h]
    def to_meta_name
      [x, y].map{|n| n.to_s.rjust(@dim_mag, '0')}.join('x') << "_#{w}x#{h}"
    end

    def px
      w * h
    end

    def quality
      (w * h + (neighbors * 10) * 0.001)
    end

    alias_method :w, :width
    alias_method :h, :height

    private
      # returns number of 10-digit places of largest relevant dimension, just so we can pad numbers with 0s
      def calculate_dimensional_magnitude
        b = if source_width && source_height
          source_width > source_height ? source_width : source_height
        else
          w > h ? w : h
        end

        return Math.log10(b).floor + 1
      end

  end
end
