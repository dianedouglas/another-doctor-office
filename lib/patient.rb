require 'table_butler'

class Patient < Table_Butler

attr_accessor:name, :birthday, :id

  def initialize(name, birthday, id = nil)
    @name = name
    @birthday = birthday
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
    @id = results.first["id"].to_i
  end
end
