require 'table_butler'

class Patient < Table_Butler

attr_accessor:name, :birthday, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthday = attributes['birthday'].split(" ")[0]
    @id = attributes['id'].to_i
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
    @id = results.first["id"].to_i
  end
end
