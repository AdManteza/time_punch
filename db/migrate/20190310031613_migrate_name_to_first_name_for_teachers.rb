class MigrateNameToFirstNameForTeachers < ActiveRecord::Migration[5.2]
  def change
    Teacher.find_in_batches do |batch|
      batch.each do |teacher|
        current_name = teacher.name

        teacher.update_attributes!(first_name: current_name, last_name: current_name)
      end
    end
  end
end
