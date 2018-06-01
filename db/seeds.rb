# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#WINES

CSV.foreach("db/csv/wines.csv") do |row|
  			new_wine = Wine.create(
  				wine_name: row[0],
  				grape_varietal: row[1],
  				origin: row[2],
  				description: row[3]
  				)
		end


#COOKIES
CSV.foreach("db/csv/cookies.csv") do |row|
  			new_wine = Cookie.create(
  				cookie_name: row[0],
  				description: row[1],
  				link: row[2]
  				)
		end

#USER
@user = User.new
@user.password = "password"
@user.user_name = "admin"
@user.email = "admin@gmail.com"
@user.zipcode = 94607
@user.save

#PAIRINGS

CSV.foreach("db/csv/pairings.csv") do |row|
  			new_pairing = Pairing.create(
  				rating: row[0],
  				wine_id: row[1],
  				cookie_id: row[2],
          user_id: row[3]
  				)
		end



#COMMENTS
@comment = Comment.new
@comment.body = "this is a test comment"
@comment.user = User.first
@comment.pairing = Pairing.first
@comment.save
