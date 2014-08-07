require 'pry'
class Table_Butler

  def self.all
    table_name = self.to_s.downcase + "s"
    if table_name == "inss"
      table_name = "ins"
    end
    class_instances = []
    results = DB.exec("SELECT * FROM #{table_name};")
    results.each do |result|
      class_instances << self.new(result)
    end
    class_instances
  end

  def ==(child)
    is_equal = true
    attributes = child.instance_variables
    attributes.each do |attribute|
      if self.instance_variable_get(attribute) != child.instance_variable_get(attribute)
        is_equal = false
      end
    end
    is_equal
  end

end
