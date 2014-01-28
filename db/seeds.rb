# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Make our statuses seed data
Status.delete_all
Status.create(
               [
                  {
                    :id => 1,
                    :name => 'Critcal',
                    :colour => 'FF0000'},  
                  {
                    :id => 2,
                    :name => 'Warning',
                    :colour => 'FF7400'
                  },
                  {
                    :id => 3,
                    :name => 'Minor',
                    :colour => 'FFD300'},
                  {
                    :id => 4,
                    :name => 'Informational',
                    :colour => '3914AF'}
                  ]
               )
