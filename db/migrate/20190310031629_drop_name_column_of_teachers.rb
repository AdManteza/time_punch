class DropNameColumnOfTeachers < ActiveRecord::Migration[5.2]
  def change
    remove_column :teachers, :name
  end
end
