README
===================

Quake log processor has 3 components. Quake Api (also the parser), Quake Dashboard and Quake Cli. The following are the setup steps.

----------


Setup
-------------

> **quake_api**

> - Clone this repository. 
> ```git clone git@github.com:EdwinRozario/quake_api.git```
> - cd quake_api/
> - bundle install
> - bundle exec rake db:create
> - bundle exec rake db:migrate
> - bundle exec rake parser:load
> This will parse the quake log file which is in db/data/ and load it to the database.
> bundle exec rails s
> Now you must have the quake_api running in port 3000

> **quake_dashboard**
> 
> - Clone quake_dashboard repository. 
> ```git clone git@github.com:EdwinRozario/quake_dashboard.git```
> - cd quake_dashboard/
> - bundle install
> - bundle exec dashing start
> This will run the dashboard server in 3030.
> - Watch localhost:3030 for the visualisation of the game logs 

> **quake_cli**
> 
> - Clone quake_dashboard repository. 
> ```git clone git@github.com:EdwinRozario/quake_cli.git```
> - cd quake_cli/
> - gem install thor
> - ```thor list``` to see the commands available
> quake_cli depends on quake_api.