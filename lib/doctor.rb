require 'pry'
require 'table_butler'

class Doctor < Table_Butler
attr_reader:name, :area, :id, :ins

  def initialize (name, area, ins, id = nil)
    @name = name
    @area = area
    @id = id
    @ins = ins
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, area_id, ins_id) VALUES ('#{@name}', '#{@area}', '#{@ins}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      current_name = result["name"]
      current_area = result["area_id"].to_i
      current_ins = result["ins_id"].to_i
      current_id = result["id"].to_i
      new_doctor = Doctor.new(current_name, current_area, current_ins, current_id)
      doctors << new_doctor
    end
    doctors
  end

  # def ==(another_doctor)
  #   (self.name == another_doctor.name) && (self.area == another_doctor.area) && (self.ins == another_doctor.ins) && (self.id == another_doctor.id)
  # end

  def add_patient(patient)
    DB.exec("INSERT INTO patients_doctors (patient_id, doctor_id) VALUES ('#{patient.id}', '#{@id}');")
  end

  def list_patients
    patients = []
    results = DB.exec("SELECT * FROM patients_doctors WHERE doctor_id = '#{@id}';")
    results.each do |result|
      patient_id = result["patient_id"].to_i
      pat_results = DB.exec("SELECT * FROM patients WHERE id = #{patient_id};")
      pat_results.each do |patient|
        patient_name = patient['name']
        patient_birthday = patient['birthday'].split(" ")[0]
        new_patient = Patient.new(patient_name, patient_birthday, patient_id)
        patients << new_patient
      end
    end
    patients
  end
end



