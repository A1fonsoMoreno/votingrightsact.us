## Voting Rights Act Petition Site

http://votingrightsact.us

Installation
------
1. `bundle install`
2. Use the example database.yml `mv ./config/example.database.yml ./config/database.yml`
3. Add development and test values to `./config/secrets.yml` for the Secret Keys listed below
3. `bundle exec rails s`

Secret Keys
-----
There are a series of ENV variables that need to be declared for many of the dependent services.  If on Heroku, you can add these via the command line utility `heroku config:add {{ key }}="{{ value }}"`

You will need to set these values:
* ADDTHIS_ID
* CHANGE_API_ID
* CHANGE_AUTH_KEY
* CHANGE_AUTH_TOKEN
* CHANGE_PETITION_ID
* CHANGE_REQUESTER_EMAIL
* GOOGLE_ANALYTICS_ID
* MANDRILL_PASSWORD
* MANDRILL_USERNAME
* SUNLIGHT_API_ID
* TWILIO_ACCOUNT_SID
* TWILIO_AUTH_TOKEN
* TWILIO_PHONE_NUMBER

Credits
------
Designed and built for [Long Distance Voter](http://longdistancevoter.org) by [Coding ZEAL](http://codingzeal.com)

![Coding ZEAL](https://googledrive.com/host/0B3TWa6M1MsWeWmxRZWhscllwTzA/ZEAL-logo-final-150.png)
