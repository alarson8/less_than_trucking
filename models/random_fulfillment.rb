class RandomFulfillment < ActiveRecord::Base
  def mark_as_best!(best_capacity:, best_deliveries:, seconds_since_epoch:)
    self.update(
      best_capacity: best_capacity,
      best_deliveries: best_deliveries,
      seconds_since_epoch: seconds_since_epoch,
      average_equal_distribution: EqualDistributionCalculator.new(log: log).calculate_average
    )
  end
end
