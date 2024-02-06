# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Locates an existing admin user by email or creates a new one.
Admin.find_or_create_by!(email: 'testadmin@test.com') do |admin|
  # Set and confirm password.
  admin.password = '123456'
  admin.password_confirmation = '123456'
  # Set basic fields.rooms
  admin.name = 'Tuffy'
  admin.phone_number = '555-555-5555'
  admin.address = 'NC State'
  admin.credit_card_info = '1234-5678-9101-1121'

  # This block is only be executed if a new instance is being created.
  # An existing instance wont be changed.
end
