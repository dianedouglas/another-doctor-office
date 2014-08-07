require 'pry'
class Table_Butler

  def all(table, class_instance)
    class_instances = []
    results = DB.exec("SELECT * FROM #{table};")
    results.each do |result|

      if result["name"] != nil
        class_instance.name = result["name"]
      end

      if result["birthday"] != nil
        class_instance.birthday = result['birthday'].split(" ")[0]
      end

      if result["area_id"] != nil
        class_instance.area = result["area_id"].to_i
      end

      if result["ins_id"] != nil
        class_instance.ins = result["ins_id"].to_i
      end

      if result["id"] != nil
        class_instance.id = result["id"].to_i
      end

      class_instances << class_instance
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
