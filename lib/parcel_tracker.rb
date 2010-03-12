require 'rubygems'
require 'builder'
require 'yaml'
require 'rexml/document'
require 'net/http'
require 'net/https'
require 'base64'
require 'fileutils'
require 'tempfile'

module ParcelTracker
  VERSION = "0.1.0"

  class Exception < ::Exception
  end

    autoload :UpsTracking, "ups_tracking"

    def self.load_all!
      [UpsTracking]
    end
end