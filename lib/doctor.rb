require 'pry'
require 'table_butler'

class Doctor < Table_Butler
attr_accessor:name, :area, :id, :ins

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



