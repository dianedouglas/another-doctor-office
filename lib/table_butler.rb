require 'pry'
class Table_Butler

  def test
    "Hello! I'm the table butler!"
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
