require 'rspec'
require 'pg'
require 'doctor'
require 'patient'
require 'pry'

test_doctor = Doctor.new("Dr. Who", "Time Travel")
test_patient = Patient.new("Dude", "1999-09-09")

DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe Doctor do

  it 'initializes a doctor class with a name and area.' do
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it 'should return name and area when asked.' do
    expect(test_doctor.name).to eq "Dr. Who"
    expect(test_doctor.area).to eq "Time Travel"
  end

  it 'will save the doctor to the doctors database' do
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end

  it 'will add a patient to the doctor table' do
    test_patient.save
    test_doctor.save
    test_doctor.add_patient(test_patient)
    expect(test_doctor.list_patients).to eq [test_patient]
  end

end
