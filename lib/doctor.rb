class Doctor
attr_reader:name, :area, :id

  def initialize (name, area, id = nil)
    @name = name
    @area = area
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@area}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      current_name = result["name"]
      current_area = result["specialty"]
      current_id = result["id"].to_i
      new_doctor = Doctor.new(current_name, current_area, current_id)
      doctors << new_doctor
    end
    doctors
  end

  def ==(another_doctor)
    (self.name == another_doctor.name) && (self.area == another_doctor.area) && (self.id == another_doctor.id)
  end
end



