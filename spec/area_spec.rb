require 'rspec'
require 'doctor'
require 'area'
require 'ins'
require 'pry'
require 'pg'

# attr_reader:test_ins, :test_area, :test_doctor

DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM areas *;')
  end
end

describe Area do
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



