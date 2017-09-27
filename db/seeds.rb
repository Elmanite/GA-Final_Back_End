# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  Hamster.create(
    name: 'Brownie',
    color: 'brown',
    victory_points: 0,
    user_id: 1
  )
end
  1.times do
  User.create(
    username: 'Admin',
    password_digest: 'Admin',
    num_of_hamsters: '1'
  )
end
