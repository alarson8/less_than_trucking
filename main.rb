require_relative "boot"

current_best_capacity = 10000000000
current_best_deliveries = 10000000000
epoch = Time.now.to_i

100000.times do
  fleet = [
    Truck.new(id: "001", capacity: 44000),
    Truck.new(id: "002", capacity: 42000),
    Truck.new(id: "003", capacity: 20000),
    Truck.new(id: "004", capacity: 24000),
  ]
  picklist = [
    Shipment.new(id: "001", capacity: 16000),
    Shipment.new(id: "002", capacity: 42000),
    Shipment.new(id: "003", capacity: 8000),
    Shipment.new(id: "004", capacity: 12000),
    Shipment.new(id: "005", capacity: 38000),
    Shipment.new(id: "006", capacity: 1200),
    Shipment.new(id: "007", capacity: 1000),
    Shipment.new(id: "009", capacity: 18000),
    Shipment.new(id: "010", capacity: 28000),
    Shipment.new(id: "011", capacity: 7500),
    Shipment.new(id: "012", capacity: 17000),
    Shipment.new(id: "013", capacity: 37000),
  ]

  fulfillment = FulfillmentCenter.new(fleet: fleet, picklist: picklist).fulfill!

  better_capacity = fulfillment.remaining_capacity <= current_best_capacity
  better_deliveries = fulfillment.deliveries < current_best_deliveries

  if better_capacity || better_deliveries
    current_best_capacity = fulfillment.remaining_capacity if better_capacity
    current_best_deliveries = fulfillment.deliveries if better_deliveries
    fulfillment.mark_as_best!(best_capacity: better_capacity, best_deliveries: better_deliveries, seconds_since_epoch: Time.now.to_i - epoch)
  end
end
