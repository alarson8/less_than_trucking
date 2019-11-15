class FulfillmentCenter
  attr_reader :picklist, :log
  attr_accessor :fleet

  def initialize(fleet:, picklist:)
    @fleet = fleet.shuffle
    @picklist = picklist.shuffle
    @log = []
  end

  def fulfill!
    delivery_count = 1
    fleet_out_for_delivery = []

    until picklist.empty?
      truck = fleet.shift
      potential_shipment = picklist.first

      while potential_shipment && truck.has_capacity_for?(potential_shipment.capacity)
        truck.load!(picklist.shift)
        potential_shipment = picklist.first
      end

      fleet_out_for_delivery << truck
      log << truck.to_h.merge(delivery: delivery_count)

      if fleet.empty?
        self.fleet = fleet_out_for_delivery.each(&:unload!).shuffle
        delivery_count += 1
      end
    end

    RandomFulfillment.create!(
      log: log,
      deliveries: log.count,
      remaining_capacity: log.inject(0){ |sum, truck_entry| sum + truck_entry[:remaining_capacity] }
    )
  end
end
