require 'opencv'
require 'yearbook/detection_collection'

module Yearbook
  class << self
    # factory method
    def Detector(*args)
      args[0].is_a?(Yearbook::Detector) ? args[0] : Yearbook::Detector.new(*args)
    end
  end

  class Detector
    DEFAULT_CLASSIFIER_FILE = File.expand_path "../../data/classifiers/haarcascade_frontalface_default.xml", __FILE__

    def initialize(classifier_filename=DEFAULT_CLASSIFIER_FILE, opts={})
      @classifier_file = classifier_filename
      @classifier = load_classifier(@classifier_file)
    end


    # :img is a Yearbook::Image
    # returns an Enumerable collection of DetectedObject objects
    def find_faces(img)
      # img.to_item is probably a sign that we shouldn't be using SimpleDelegator here
      return Yearbook::DetectionCollection(@classifier.detect_objects(img.to_item))
    end


    private

      def load_classifier(fname)
        OpenCV::CvHaarClassifierCascade::load( fname )
      end

  end
end


