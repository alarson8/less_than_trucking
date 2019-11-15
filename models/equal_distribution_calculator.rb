class EqualDistributionCalculator
  attr_reader :log

  def initialize(log:)
    @log = log
  end

  def calculate_average
    unused_capacities = log.map{ |truck_log| (truck_log["remaining_capacity"] / truck_log["capacity"].to_f).round(2) }
    average_unused_capacity = (unused_capacities.inject(:+) / unused_capacities.count.to_f).round(2)
    differences_between_average = unused_capacities.map { |unused_capacity| (unused_capacity - average_unused_capacity).round(2).abs }
    ((1 - (differences_between_average.inject(:+) / unused_capacities.count.to_f).round(4)) * 100).round(2)
  end
end
