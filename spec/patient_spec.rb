require 'rspec'
require 'pg'
require 'patient'
require 'doctor'

test_doctor = Doctor.new("Dr. Who", "Time Travel")
test_patient = Patient.new("Dude", "1999-09-09")
DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe Patient do

  it 'initializes a patient class with a name and birthday.' do
    expect(test_patient).to be_an_instance_of Patient
  end

  it 'should return the name and birthday when asked.' do
    expect(test_patient.name).to eq "Dude"
    expect(test_patient.birthday).to eq "1999-09-09"
  end

  it 'should return no patients initially' do
    expect(Patient.all).to eq []
  end

  it 'should save the patient' do
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

end
