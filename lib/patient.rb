class Patient

attr_reader:name, :birthday, :id

  def initialize(name, birthday, id = nil)
    @name = name
    @birthday = birthday
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      patient_name = result['name']
      patient_birthday = result['birthday'].split(" ")[0]
      patient_id = result['id'].to_i
      new_patient = Patient.new(patient_name, patient_birthday, patient_id)
      patients << new_patient
    end
    patients
  end

  def == (another_patient)
    (self.name == another_patient.name) && (self.birthday == another_patient.birthday) && (self.id == another_patient.id)
  end
end
