class AddTimePunchCodeToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :time_punch_code, :string
  end
end
