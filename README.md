Strategy - Random Filling, Until all the shipments have been delivered, start with a random empty truck and load it until the next shipment will not fit. That truck is then logged as a delivery and then this process continues with all remaining empty trucks.  If shipments remain and all trucks are out for delivery, they are considered unloaded and requeued to continue the loading process. Equally distributed amongst cars that are out for delivery


Pros - Abstract from assumptions and let results help draw conclusions of best packing strategies
Cons - Time, Duplication, Larger Datasets
Goal - Mapping how best strategy evolved over time; Have thourough logging for me to see whats going on between time, average equal distribution, deliveries made, and unused capacity

How this code functions -
main.rb indefinilty builds our dataset of random fulfillments in which any currently best packed shipment is noted

How to:

Use ruby 2.4.6
gem install bundler
bundle install

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:migrate RAILS_ENV=test

bundle exec rspec spec (should see green tests)
