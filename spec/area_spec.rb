require 'rspec_helper'

describe Area do
  before do
    create_test_objects
  end

  it "initalizes with an area of a doctor" do
    expect(@test_area).to be_an_instance_of Area
  end

  it "saves the area" do
    expect(Area.all).to eq [@test_area]
  end

  it "should return the doctor of a given area" do
    expect(@test_area.doctors).to eq [@test_doctor]
  end
end



