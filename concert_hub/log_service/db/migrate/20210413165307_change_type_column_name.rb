class ChangeTypeColumnName < ActiveRecord::Migration[6.1]
  def change
    # "type" зарезервированное слово для STI, поэтому
    # в ActiveRecord models мы не можем назвать колонку с таким именем.
    # STI (Single Table Inheritance) - перенос наследования на таблицу,
    # при котором поле "type" идентифицирует название класса в иерархии.
    rename_column :entries, :type, :entry_type
  end
end
