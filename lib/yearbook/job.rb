module Yearbook
  class Job

    attr_reader :faces
    attr_reader :filename
    def initialize(fname, opts={})
      @filename = fname
      @image = Yearbook::Image(@filename)
      @detector = Yearbook::Detector(opts[:classifier])


      @faces = find_faces!(@detector, @image)
      parse_path(@filename)
    end

    def face_count
      @faces.count
    end


    def talk(talk_type=:verbose)
      outs = ""
      case talk_type
      when :verbose
        print(no_write: true) do |face_path, face|
          ## default printing option:
          # filename
          # dimension stuff
          outs << "\n" << @filename << "\n"
          outs << "\t#{face.x}x#{face.y}, #{face.w}x#{face.h}\tquality: #{face.quality} neighbors: #{face.neighbors}"
          outs << "\n"
        end
      when :count
        outs << [@filename, self.face_count].join("\t")
      else

      end

      return outs
    end

    def print(opts={}, &blk)
      printable_faces(opts).each do |face|
        face_path = face_pathname(face)
        yield(face_path, face) if block_given?

        unless opts[:no_write] == true
          @image.cut_out(face).write face_path
        end
      end
    end


    private
      def find_faces!(dct, img)
        dct.find_faces(img).by_quality
      end

      def parse_path(path)
        pathname = Pathname.new(path)
        @dirname = pathname.dirname.to_s
        @extname = pathname.extname
        @basename = pathname.basename(@extname).to_s
      end

      def printable_faces(opts={})
        if opts[:best] == true
          Array(@faces.best_candidate)
        else
          fcount = opts[:count].to_i - 1

          @faces[0..fcount]
        end
      end

      # [00x]x[00y]-[w]x[h]
      def face_pathname(face)
        fdims =  [face.x, face.y].map{|n| n.to_s.rjust( dim_mag, '0')}.join('x') << "_#{face.w}x#{face.h}"

        "#{@basename}.#{fdims}#{@extname}"
      end



      # returns number of 10-digit places of largest relevant dimension, just so we can pad numbers with 0s
      def dim_mag
        @_dim_mag ||= Math.log10([@image.width, @image.height].max).floor + 1
      end



  end
end
