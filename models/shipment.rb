class Shipment
  attr_reader :id, :capacity

  def initialize(id:, capacity:)
    @id = id
    @capacity = capacity
  end

  def to_h
    {
      id: id,
      capacity: capacity,
    }
  end
end
