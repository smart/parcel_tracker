require 'spec_helper'

describe ParcelTracker::UpsTracking do
  it "initializes" do
    ParcelTracker::UpsTracking.new.should be_a(ParcelTracker::UpsTracking)
  end
end
