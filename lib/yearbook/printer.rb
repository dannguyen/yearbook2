module Yearbook
  class Printer

    attr_reader :faces, :source_image
    def initialize(arr_faces, img, opts={})
      @faces = arr_faces
      @source_image = load_image(img)
    end


    def print
      image = load_image(@source_image_file)
      Array(@faces).each do |face|
        face_img = cut_out(image, face)
      end
    end


    private
      # :image is MiniMagick::Image
      # :face is a Yearbook::Face object
      # returns:
      # todo:  //returns a MiniMagick::Image object that is a subset of :image
      def cut_out(image, face)
        image.sub_rect(face)
      end

      # TODO:returns a MiniMagick::Image object loaded from image_fname
      #
      # :img could be a filename or a CV:Mat type object
      def load_image(img)
        case img
        when OpenCV::CvMat
          img
        else
          OpenCV::CvMat.load(img)
        end
      end

      # TODO: :image is MiniMagick::Image
      # :image is CvMat
      # writes file to :out_name
      def write(image, out_name)
        image.save(out_name)
      end
  end
end
