require 'thor'
module Yearbook
  class CLI < Thor

    desc "find PATH", "find faces in files"
#    option :min_width, :type => :numeric, :aliases => '--mw'
    option :count, :type => :boolean, :aliases => '-c', :default => false, :banner => 'Provide just a count'
    def find(*path)
      Dir.glob(path).each do |image_filename|
        image_file = Yearbook::Image.new(image_filename)
        faces = Yearbook::Detector.new.find(image_file)

        if options[:count] == true
          say "#{image_filename}\t#{faces.count}"
        else
          faces.each do |face|
            say image_filename << "\t" << face.to_h.map{|(k,v)| "#{k}: #{v}"}.join("\t")
          end
        end
      end
    end

    desc "find IMAGE_FILE", "Find faces in a file, returns list of created files"
#    option :min_width, :type => :numeric, :aliases => '--mw'
    option :best, :type => :boolean, :aliases => '-b', :default => false, :banner => 'Just print out the first face'
    option :count, :type => :numeric, :aliases => '-c', :banner => 'The max number of faces, by quality, to print out'
    def print(*path)
      Dir.glob(path).each do |image_filename|
        image_file = Yearbook::Image.new(image_filename)
        faces = Yearbook::Detector.new.find(image_file).by_quality

        if options[:best] == true
          face_count = 1
        else
          face_count = options[:count].to_i
        end

        faces[0..face_count-1].each do |face|
          face_name = "#{image_file.basename}.#{face.to_meta_name}#{image_file.extname}"
          say face_name
          image_file.cut_out(face).print face_name
        end
      end
    end

  end


  # desc "mark"
  # desc "redact", "black out the faces/eyes"
  # desc "blur", "blur out the faces"
  # desc "replace", "replace faces with an image"
  # yearbook photo.jpg face.jpg -w 300 -h 200
  #                           -r 4x5
  #                           -q --quality, 0..100
  #                           -mw 200 -mh 100
  #                           --confidence=10
  #                           --circle
  #                           --best --csv
  #                           --face-data="faces.xml" --eyes-data="eyes.xml"


end
