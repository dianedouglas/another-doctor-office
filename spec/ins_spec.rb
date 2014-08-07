require 'rspec_helper'

describe Ins do
  before do
    create_test_objects
  end

  it "intializes with a company name" do
    expect(@test_ins).to be_an_instance_of Ins
  end

  it "should return the name of the company" do
    expect(@test_ins.name).to eq 'Health Cross'
  end

  it "saves the company into a list of companies" do
    expect(@test_ins.all('ins', Ins.new(nil, nil))).to eq [@test_ins]
  end

  it "should return the doctors for a given insurance company" do
    expect(@test_ins.doctors).to eq [@test_doctor]
  end
end
