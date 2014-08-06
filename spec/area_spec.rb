require 'rspec'
require 'doctor'
require 'area'
require 'pry'
require 'pg'

test_doctor = Doctor.new("Dr. Who", 1)
DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM areas *;')
  end
end

describe Area do
  it "initalizes with an area of a doctor" do
    test_area = Area.new('Time Travel')
    test_area.save
    expect(test_area).to be_an_instance_of Area
  end

  it "saves the area" do
    test_area = Area.new('Time Travel')
    test_area.save
    expect(Area.all).to eq [test_area]
  end

  it "should return the doctor of a given area" do
    test_area = Area.new('Time Travel')
    test_area.save
    dr_who = Doctor.new('Tom Baker', test_area.id)
    dr_who.save
    expect(test_area.doctors).to eq [dr_who]
  end
end



