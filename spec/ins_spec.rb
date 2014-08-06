require 'rspec'
require 'doctor'
require 'area'
require 'pry'
require 'pg'
require 'ins'

test_ins = Ins.new('Health Cross')
test_doctor = Doctor.new("Dr. Who", 1)
DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM ins *;')
  end
end

describe Ins do
  it "intializes with a company name" do
    expect(test_ins).to be_an_instance_of Ins
  end

  it "should return the name of the company" do
    expect(test_ins.name).to eq 'Health Cross'
  end

  it "saves the company into a list of companies" do
    test_ins.save
    expect(Ins.all).to eq [test_ins]
  end
end
