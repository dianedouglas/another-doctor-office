require 'table_butler'

class Ins < Table_Butler

attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def save
    results = DB.exec("INSERT INTO ins (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def doctors
    doctors = []
    results = DB.exec("SELECT * FROM doctors WHERE ins_id = ('#{@id}');")
    results.each do |result|
      current_name = result['name']
      current_area = result['area_id'].to_i
      current_ins = result['ins_id'].to_i
      current_id = result['id'].to_i
      current_doctor = Doctor.new({'name' => current_name, 'area_id' => current_area, 'ins_id' => current_ins, 'id' => current_id})
      doctors << current_doctor
    end
    doctors
  end
end
