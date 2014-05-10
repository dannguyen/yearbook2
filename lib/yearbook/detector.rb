require 'opencv'
require 'yearbook/detection_collection'

module Yearbook
  class Detector

    DEFAULT_CLASSIFIER_FILE = File.expand_path "../../data/classifiers/haarcascade_frontalface_default.xml", __FILE__

    attr_reader :classifier_file
    def initialize(classifier_filename=DEFAULT_CLASSIFIER_FILE, opts={})
      @classifier_file = classifier_filename
      @classifier = load_classifier(@classifier_file)
    end


    # :img is a Yearbook::Image
    # returns an Enumerable collection of DetectedObject objects
    def find(img)
      return DetectionCollection(@classifier.detect_objects(img.to_item), img)
    end


    private

      def load_classifier(fname)
        OpenCV::CvHaarClassifierCascade::load( fname )
      end

  end
end


