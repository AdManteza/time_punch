# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
teachers = Teacher.create([
  { name: 'Teacher_1' },
  { name: 'Teacher_2' },
  { name: 'Teacher_3' }
])

puts "#{teachers.count} Teachers created!"
