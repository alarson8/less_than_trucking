require "active_record_helper"

RSpec.describe RandomFulfillment do
  after(:each) do
    RandomFulfillment.destroy_all
  end

  describe "#mark_as_best!" do
    it "is updated as the current best" do
      fulfillment = RandomFulfillment.create(
        deliveries: 3,
        remaining_capacity: 27,
        log: [
          { capacity: 100, remaining_capacity: 10 },
          { capacity: 100, remaining_capacity: 12 },
          { capacity: 100, remaining_capacity: 5 },
        ]
      )

      expect{ fulfillment.mark_as_best!(best_capacity: true, best_deliveries: true, seconds_since_epoch: 10) }.
        to change { fulfillment.best_capacity }.to(true).
        and change { fulfillment.best_deliveries }.to(true).
        and change { fulfillment.seconds_since_epoch }.to(10).
        and change { fulfillment.average_equal_distribution }.to(97.33)
    end
  end
end
