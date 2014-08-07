require 'rspec'
require 'pg'
require 'doctor'
require 'patient'
require 'ins'
require 'area'

DB = PG.connect({:dbname => 'doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec('DELETE FROM areas *;')
    DB.exec('DELETE FROM ins *;')
  end
end

def create_test_objects
    @test_ins = Ins.new('Health Cross')
    @test_ins.save
    @test_area = Area.new('Time Travel')
    @test_area.save
    @test_doctor = Doctor.new("Dr. Who", @test_area.id, @test_ins.id)
    @test_doctor.save
    @test_patient = Patient.new("Dude", "1999-09-09")
    @test_patient.save
end
