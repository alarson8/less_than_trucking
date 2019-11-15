require "spec_helper"

RSpec.describe EqualDistributionCalculator do
  describe "calculate_average" do
    it "returns the percentage of how equally capacity was distributed among trucks" do
      log = [
        { capacity: 100, remaining_capacity: 10 },
        { capacity: 100, remaining_capacity: 12 },
        { capacity: 100, remaining_capacity: 5 },
      ]

      calculator = EqualDistributionCalculator.new(log: log)

      expect(calculator.calculate_average).to eq(97.33)
    end
  end
end
