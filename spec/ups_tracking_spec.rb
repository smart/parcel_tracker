require 'spec_helper'

describe ParcelTracker::UpsTracking do
  it "initializes" do
    ParcelTracker::UpsTracking.new.should be_a(ParcelTracker::UpsTracking)
  end

  it "should get a response" do
    a = ParcelTracker::UpsTracking.new
    a.track.should == true
  end
end
