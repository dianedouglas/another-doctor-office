class Area
  attr_reader:area, :id

  def initialize(area, id = nil)
    @area = area
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO areas (name) VALUES ('#{@area}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    areas = []
    results = DB.exec("SELECT * FROM areas;")
    results.each do |result|
      result_area = result['name']
      result_id = result['id'].to_i
      current_area = Area.new(result_area, result_id)
      areas << current_area
    end
    areas
  end

  def ==(another_area)
    (self.area == another_area.area) && (self.id == another_area.id)
  end

  def doctors
    doctors = []
    results = DB.exec("SELECT * FROM doctors WHERE area_id = ('#{@id}')")
    results.each do |result|
      doctor_name = result['name']
      doctor_area_id = result['area_id'].to_i
      doctor_id = result['id'].to_i
      current_doctor = Doctor.new(doctor_name, doctor_area_id, doctor_id)
      doctors << current_doctor
    end
    doctors
  end

end
