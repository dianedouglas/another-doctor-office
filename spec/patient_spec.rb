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
    DB.exec("DELETE FROM patients *;")
  end
end

describe Patient do
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

  it 'initializes a patient class with a name and birthday.' do
    expect(@test_patient).to be_an_instance_of Patient
  end

  it 'should return the name and birthday when asked.' do
    expect(@test_patient.name).to eq "Dude"
    expect(@test_patient.birthday).to eq "1999-09-09"
  end

  it 'should save the patient' do
    expect(Patient.all).to eq [@test_patient]
  end

end
