# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.new email:'qw3r@fps.hu', password:'devise', password_confirmation: 'devise', username:'qw3r', firstname:'Istvan', lastname: 'Demeter'
u.admin = true
u.save

User.create email:'qw3r@fps.hu', password:'devise', password_confirmation: 'devise', username:'qw3r', firstname:'Istvan', lastname: 'Demeter'
User.create email:'demeter@fps.hu', password:'devise', password_confirmation: 'devise', username:'devise', firstname:'Istvan', lastname: 'Demeter'
User.create email:'istvan@fps.hu', password:'devise', password_confirmation: 'devise', username:'teszt', firstname:'Istvan', lastname: 'Demeter'
User.create email:'demeter.istvan@gmail.com', password:'devise', password_confirmation: 'devise', username:'demeter', firstname:'Istvan', lastname: 'Demeter'