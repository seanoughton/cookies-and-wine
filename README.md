# README
#Application Description
#Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)

This is a Fantasy Basketball Sinatra app. Mulitple users can create Fantasy NBA Basketball teams out of a pool of available players.  A user can also add players to the pool of available players by creating players.


## Installation

Fork and clone this repository. Navigate to the root folder. Use bundle install to install all of the necessary gems. There is a database of players already. However, if you want to find or create your own CSV list of players, you can do that. Place the csv file in the db/csv folder. Update the name of the csv file in the Rake Task seed_db. Then run rake seed_db in the console to seed the database with your players.


## Usage

Run: Use shotgun to start the app and navigate to the url that shotgun provides.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seanoughton/cookies-and-wine. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sinatra-Portfolio-Project-Fantasy-Basketball project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sf_bay_area_concerts_cli_app/blob/master/CODE_OF_CONDUCT.md).
