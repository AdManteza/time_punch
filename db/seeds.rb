# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
teachers = Teacher.create([
  { first_name: 'Teacher_1', last_name: 'Teacher_1_Lname', time_punch_code: SecureRandom.hex(3).upcase },
  { first_name: 'Teacher_2', last_name: 'Teacher_2_Lname', time_punch_code: SecureRandom.hex(3).upcase },
  { first_name: 'Teacher_3', last_name: 'Teacher_3_Lname', time_punch_code: SecureRandom.hex(3).upcase }
])

puts "#{teachers.count} Teachers created!"
