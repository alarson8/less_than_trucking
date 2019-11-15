class Shipment
  attr_reader :id, :capacity

  def initialize(id:, capacity:)
    @id = id
    @capacity = capacity
  end
end
