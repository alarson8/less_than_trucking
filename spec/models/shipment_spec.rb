require "spec_helper"

RSpec.describe Shipment do
  describe "#to_h" do
    it "is the hash representation of the shipment" do
      shipment = Shipment.new(id: "1", capacity: 200)
      expect(shipment.to_h).to eq(
        {
          id: "1",
          capacity: 200,
        }
      )
    end
  end
end
