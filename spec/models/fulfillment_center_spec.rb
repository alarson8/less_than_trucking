require "active_record_helper"

RSpec.describe FulfillmentCenter do
  after(:each) do
    RandomFulfillment.destroy_all
  end

  describe "#fulfill!" do
    context "when a truck cannot take the next shipment" do
      it "creates a random fulfillment with the shipment passing to the next truck" do
        fleet = [Truck.new(id: "2", capacity: 200), Truck.new(id: "5", capacity: 100)]
        allow(fleet).to receive(:shuffle).and_return(fleet)
        picklist = [Shipment.new(id: "1", capacity: 175), Shipment.new(id: "4", capacity: 75), Shipment.new(id: "5", capacity: 25)]
        allow(picklist).to receive(:shuffle).and_return(picklist)

        fullfillment_center = FulfillmentCenter.new(picklist: picklist, fleet: fleet)

        expect(RandomFulfillment).
        to receive(:create!).
        with(
          log: [
            {
              id: "2",
              shipments: [{ id: "1", capacity: 175 }],
              capacity: 200,
              remaining_capacity: 25,
              delivery: 1
            },
            {
              id: "5",
              shipments: [{ id: "4", capacity: 75 }, { id: "5", capacity: 25 }],
              capacity: 100,
              remaining_capacity: 0,
              delivery: 1
            },
          ],
          deliveries: 2,
          remaining_capacity: 25,
        )

        fullfillment_center.fulfill!
      end
    end
  end

  context "when a truck can only take one shipment at a time" do
    it "creates a random fulfillment with deliveries" do
      fleet = [Truck.new(id: "5", capacity: 80)]
      allow(fleet).to receive(:shuffle).and_return(fleet)
      picklist = [Shipment.new(id: "1", capacity: 60), Shipment.new(id: "4", capacity: 70)]
      allow(picklist).to receive(:shuffle).and_return(picklist)

      fullfillment_center = FulfillmentCenter.new(picklist: picklist, fleet: fleet)

      expect(RandomFulfillment).
      to receive(:create!).
      with(
        log: [
          {
            id: "5",
            shipments: [{ id: "1", capacity: 60 }],
            capacity: 80,
            remaining_capacity: 20,
            delivery: 1
          },
          {
            id: "5",
            shipments: [{ id: "4", capacity: 70 }],
            capacity: 80,
            remaining_capacity: 10,
            delivery: 2
          },
        ],
        deliveries: 2,
        remaining_capacity: 30,
      )

      fullfillment_center.fulfill!
    end
  end
end
