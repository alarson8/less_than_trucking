class FulfillmentCenter
  attr_reader :fleet, :picklist

  def initialize(fleet:, picklist:)
    @fleet = fleet
    @picklist = picklist
  end
end
