require 'rspec_helper'

describe Patient do
  before do
    create_test_objects
  end

  it 'initializes a patient class with a name and birthday.' do
    expect(@test_patient).to be_an_instance_of Patient
  end

  it 'should return the name and birthday when asked.' do
    expect(@test_patient.name).to eq "Dude"
    expect(@test_patient.birthday).to eq "1999-09-09"
  end

  it 'should save the patient' do
    expect(@test_patient.all('patients', Patient.new(nil, nil, nil))).to eq [@test_patient]
  end

end
