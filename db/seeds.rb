# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(firstname: "Marin", lastname: "Procureur", email: "marin.procureur@gmail.com", signature: "", password: "Azerty123!!/", password_confirmation: "Azerty123!!/");

if Rails.env == 'test'
  User.create!(firstname: "test", lastname: "test", email: "test@test.fr", signature: "", password: "test", password_confirmation: "test");
end
