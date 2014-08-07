require 'table_butler'

class Patient < Table_Butler

attr_accessor:name, :birthday, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthday = attributes['birthday'].split(" ")[0]
    @id = attributes['id'].to_i
  end

end
