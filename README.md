# README

- Default rails app in api mode

Quickstart:
- make sure ruby is installed
- install a gem manager (e.g. rvm)
`$ gem install bundler`
`$ bundle install`
`$ rake db:setup`
`$ rake db:migrate`
`$ rails s`


Gems added:

- active_model_serializers - easily create serializers

Notes:

- Tried to keep things as 'vanilla' as possible - less coding means shorter iteration cycles means less time wasted.
- Decided to name the model Timecard instead of TimeCard since the requested api path was timecards instead of time_cards. I strongly believe in convention over configuration for rails.
- Decided to go with active_model_serializers for custom serialization. Just really nice way to serialize objects to json - seperates the object from the presentation / view. 

- Although time_entry[time] is specified as DateTime, I figured only the time part was really important (which is why there is timecard[occurrence]) so I could have further optimized it by storing it as an integer representing the seconds from midnight.
- total_hours is also a bit ambiguous so I went with a float. Better to have excess useless data than to be missing vital information. Also the way I calculated total_hours was that I would ONLY consider the first 2 time_entries on a timecard. Any less sets the total_hours to nil and any more doesn't affect the total_hours. If one of the two time_entries is removed, it will recalculate the total_hours using the first 2. My interpretation of this is that each timecard should ONLY have 2 time_entries - one representing the start time and one representing the end time - and any other records of the time should be done on a new timecard. 

- Timecards has a dependent: delete_all association with time_entries. It works fine for now, but if time_entries ever requires some callback functions on destroy then it will be bad.
