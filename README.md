**Mastery Code Challenge: Less Than Trucking**

Thanks for taking the time to review this submission and below you will see a breakdown of my approach, and how to navigate the project.

**Fulfilment Strategy - Random**

I chose a random strategy that rotates through all trucks by randomly sending one at a time with random shipments until the picklist is empty, logging the result, and then setting it to the best fulfillment if it beat the previous best fulfillment.  

Pros: Abstract from assumptions and let results help draw conclusions of best packing strategies.
Cons: Time for larger permutations


My two favorite quirks of this random strategy is that it will:

1. send a truck for delivery if the current shipment doesn't fit even if the following shipment may have. I want the option to get data on how good it is to fill a truck to the max as well as maybe leaving a little room in each.

2. per the above, its possible to send a truck out for delivery without any shipments (not optimal)

**SETUP**
requires ruby 2.4.6
```
gem install bundler
bundle install
```

_may have to run_ `gem install standalone_migrations`

```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:migrate RAILS_ENV=test

bundle exec rspec spec (should see 11 green tests)
```
The code is organized similar to a rails project with a db folder holding the migrations and schema, a models folder holding our necessary objects and a spec folder testing our assumptions.

main.rb builds our dataset of random fulfillments using a fulfillment center and recording the results to the RandomFulfillment record.

In order to generate your own random fulfillments run `ruby main.rb` in your terminal; this will take a bit to generate.

Once complete, we can check our results by doing the below within terminal from the root directory.

```bash
irb
require 'pry'
pry
require_relative "boot"
lowest_remaining_capacity = RandomFulfillment.where(best_capacity: true).minimum("remaining_capacity")
most_efficient_fulfillment = RandomFulfillment.where(remaining_capacity: lowest_remaining_capacity).max_by(&:average_equal_distribution)
```

**From 100,000 iterations the below was the best**

```ruby
[8] pry(main)> lowest_remaining_capacity = RandomFulfillment.where(best_capacity: true).minimum("remaining_capacity")
=> 34300
[9] pry(main)> most_efficient_fulfillment = RandomFulfillment.where(remaining_capacity: lowest_remaining_capacity).max_by(&:average_equal_distribution)

=> #<RandomFulfillment:0x00007f9e2ab22d50
 id: 70775,
 best_capacity: true,
 best_deliveries: false,
 log:
  [{"id"=>"001",
    "capacity"=>44000,
    "delivery"=>1,
    "shipments"=>[{"id"=>"002", "capacity"=>42000}],
    "remaining_capacity"=>2000},
   {"id"=>"002",
    "capacity"=>42000,
    "delivery"=>1,
    "shipments"=>[{"id"=>"013", "capacity"=>37000}],
    "remaining_capacity"=>5000},
   {"id"=>"004",
    "capacity"=>24000,
    "delivery"=>1,
    "shipments"=>[{"id"=>"004", "capacity"=>12000}, {"id"=>"003", "capacity"=>8000}],
    "remaining_capacity"=>4000},
   {"id"=>"003",
    "capacity"=>20000,
    "delivery"=>1,
    "shipments"=>[{"id"=>"012", "capacity"=>17000}],
    "remaining_capacity"=>3000},
   {"id"=>"003",
    "capacity"=>20000,
    "delivery"=>2,
    "shipments"=>[{"id"=>"001", "capacity"=>16000}, {"id"=>"006", "capacity"=>1200}],
    "remaining_capacity"=>2800},
   {"id"=>"002",
    "capacity"=>42000,
    "delivery"=>2,
    "shipments"=>[{"id"=>"011", "capacity"=>7500}, {"id"=>"010", "capacity"=>28000}],
    "remaining_capacity"=>6500},
   {"id"=>"004",
    "capacity"=>24000,
    "delivery"=>2,
    "shipments"=>[{"id"=>"009", "capacity"=>18000}, {"id"=>"007", "capacity"=>1000}],
    "remaining_capacity"=>5000},
   {"id"=>"001",
    "capacity"=>44000,
    "delivery"=>2,
    "shipments"=>[{"id"=>"005", "capacity"=>38000}],
    "remaining_capacity"=>6000}],
 deliveries: 8,
 remaining_capacity: 34300,
 average_equal_distribution: 97.12,
 seconds_since_epoch: 310,
 created_at: 2019-11-15 09:15:08 UTC,
 updated_at: 2019-11-15 09:15:08 UTC>
 ```
