class Ins
attr_reader:name, :id
  def initialize(name, id = nil)
    @name = name
    @id = id
  end

  def save
    results = DB.exec("INSERT INTO ins (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    ins_company = []
    results = DB.exec("SELECT * FROM ins;")
    results.each do |result|
      ins_company_name = result['name']
      ins_company_id = result['id'].to_i
      current_ins_company = Ins.new(ins_company_name, ins_company_id)
      ins_company << current_ins_company
    end
    ins_company
  end

  def ==(another_ins)
    (self.name == another_ins.name) && (self.id == another_ins.id)
  end
end
