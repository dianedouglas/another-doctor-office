require 'rspec_helper'

describe Doctor do
  before do
    create_test_objects
  end

  it 'initializes a doctor class with a name and area.' do
    expect(@test_doctor).to be_an_instance_of Doctor
  end

  it 'should return name and area when asked.' do
    expect(@test_doctor.name).to eq "Dr. Who"
    expect(@test_doctor.area).to eq @test_area.id
  end

  it 'will save the doctor to the doctors database' do
    expect(Doctor.all).to eq [@test_doctor]
  end

  it 'will add a patient to the doctor table' do
    @test_doctor.add_patient(@test_patient)
    expect(@test_doctor.list_patients).to eq [@test_patient]
  end

end
