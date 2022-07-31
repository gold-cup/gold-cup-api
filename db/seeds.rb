# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Division.create(code: 'B10', name: 'Boys 12-14', min_date: Date.parse('05-08-2010'), max_date: Date.parse('06-08-2007'))
Division.create(code: 'G10', name: 'Girls 12-14', min_date: Date.parse('05-08-2010'), max_date: Date.parse('06-08-2007'), female_only: true)
Division.create(code: 'B07', name: 'Boys 15-17', min_date: Date.parse('05-08-2007'), max_date: Date.parse('06-08-2004'))
Division.create(code: 'G10', name: 'Girls 12-14', min_date: Date.parse('05-08-2007'), max_date: Date.parse('06-08-2004'), female_only: true)
Division.create(code: 'M04', name: 'Mens 18-20', min_date: Date.parse('05-08-2004'), max_date: Date.parse('06-08-2001'))
Division.create(code: 'W04', name: 'Womens 18+', min_date: Date.parse('05-08-2004'), female_only: true)
Division.create(code: 'M01', name: 'Mens 21+', min_date: Date.parse('05-08-2001'))
Division.create(code: 'M87', name: 'Mens 35+', min_date: Date.parse('05-08-1987'))
Division.create(code: 'M72', name: 'Mens 50+', min_date: Date.parse('05-08-1972'))
