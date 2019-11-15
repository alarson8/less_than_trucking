require "spec_helper"

RSpec.describe Truck do
  describe "#has_capacity_for?" do
    context "when there is enough capacity" do
      it "has capacity" do
        truck = Truck.new(id: "1", capacity: 100)
        expect(truck).to have_capacity_for(100)
      end
    end

    context "when there is not enough capacity" do
      it "does not have capacity" do
        truck = Truck.new(id: "1", capacity: 100)
        expect(truck).to_not have_capacity_for(101)
      end
    end
  end

  describe "#load!" do
    it "adds the shipment to the cargo" do
      truck = Truck.new(id: "1", capacity: 100)
      shipment = double(capacity: 50)

      truck.load!(shipment)

      expect(truck.cargo).to match_array([shipment])
    end
  end

  describe "#remaining_capacity" do
    it "is the difference between the capacity and cargo" do
      truck = Truck.new(id: "1", capacity: 100)
      shipment = double(capacity: 50)
      shipment_2 = double(capacity: 30)

      truck.load!(shipment)
      truck.load!(shipment_2)

      expect(truck.remaining_capacity).to eq(20)
    end
  end

  describe "#unload!" do
    it "empties the cargo" do
      truck = Truck.new(id: "1", capacity: 100)
      shipment = double(capacity: 50)
      truck.load!(shipment)

      truck.unload!

      expect(truck.cargo).to be_empty
    end
  end

  describe "#to_h" do
    it "is the hash representation of the truck" do
      truck = Truck.new(id: "1", capacity: 100)
      shipment = double(capacity: 30, to_h: { id: 1, capacity: 30 })
      shipment_2 = double(capacity: 50, to_h: { id: 4, capacity: 50 })

      truck.load!(shipment)
      truck.load!(shipment_2)

      expect(truck.to_h).to eq(
        {
          id: "1",
          shipments: [
            { id: 1, capacity: 30, },
            { id: 4, capacity: 50, },
          ],
          capacity: 100,
          remaining_capacity: 20,
        }
      )
    end
  end
end
