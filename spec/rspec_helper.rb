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
    @test_ins = Ins.new({'name' => 'Health Cross'})
    @test_ins.save
    @test_area = Area.new({'name' => 'Time Travel'})
    @test_area.save
    @test_doctor = Doctor.new({'name' => "Dr. Who", 'area_id' => @test_area.id, 'ins_id' => @test_ins.id})
    @test_doctor.save
    @test_patient = Patient.new({'name' => "Dude", 'birthday' => "1999-09-09"})
    @test_patient.save
end
