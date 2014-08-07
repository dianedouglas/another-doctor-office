require 'rspec'
require 'doctor'
require 'area'
require 'pry'
require 'pg'
require 'ins'
# attr_reader:test_ins, :test_area, :test_doctor


DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM ins *;')
  end
end

describe Ins do
    before(:each) do
    @test_ins = Ins.new('Health Cross')
    @test_ins.save
    @test_area = Area.new('Time Travel')
    @test_area.save
    @test_doctor = Doctor.new("Dr. Who", @test_area.id, @test_ins.id)
    @test_doctor.save
    @test_patient = Patient.new("Dude", "1999-09-09")
    @test_patient.save
  end

  it "intializes with a company name" do
    expect(@test_ins).to be_an_instance_of Ins
  end

  it "should return the name of the company" do
    expect(@test_ins.name).to eq 'Health Cross'
  end

  it "saves the company into a list of companies" do
    expect(Ins.all).to eq [@test_ins]
  end

  it "should return the doctors for a given insurance company" do
    expect(@test_ins.doctors).to eq [@test_doctor]
  end
end
