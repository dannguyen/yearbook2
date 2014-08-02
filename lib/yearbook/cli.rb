require 'thor'
module Yearbook
  class CLI < Thor
    desc "find PATH", "find faces in files"
#    option :min_width, :type => :numeric, :aliases => '--mw'
    option :count, :type => :boolean, :aliases => '-c', :default => false, :banner => 'Provide just a count'
    def find(*path)
      detector = Yearbook::Detector.new
      Dir.glob(path).each do |image_filename|
        job = Yearbook::Job.new(image_filename, classifier: detector)

        if options[:count] == true
          say job.talk(:count)
        else
          say job.talk
        end
      end
    end

    desc "find IMAGE_FILE", "Find faces in a file, returns list of created files"
#    option :min_width, :type => :numeric, :aliases => '--mw'
    option :best, :type => :boolean, :aliases => '-b', :default => false, :banner => 'Just print out the first face'
    option :count, :type => :numeric, :aliases => '-c', :banner => 'The max number of faces, by quality, to print out'
    def print(*path)
      detector = Yearbook::Detector.new
      Dir.glob(path).each do |image_filename|
        job = Yearbook::Job.new(image_filename, classifier: detector)
        job.print(options) do |face_name, face|
          say face_name
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



=begin
Notes:
------

- config
  - set <file>
  - show

- detect <file>
  --type  :face
  --json
    --nested

- crop
  -- feather
  -- resize
  -- fit
  -- room [50px,50px,10px,9px]

- redact
  - cut
  - blur
  - replace



=end
