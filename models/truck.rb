class Truck
  attr_reader :id, :capacity, :cargo

  def initialize(id:, capacity:)
    @id = id
    @capacity = capacity
    @cargo = []
  end

  def has_capacity_for?(capacity)
    remaining_capacity >= capacity
  end

  def load!(shipment)
    cargo << shipment
  end

  def remaining_capacity
    capacity - cargo.inject(0) { |sum, cargo| sum + cargo.capacity }
  end

  def unload!
    cargo.clear
  end

  def to_h
    {
      id: id,
      shipments: cargo.map(&:to_h),
      capacity: capacity,
      remaining_capacity: remaining_capacity,
    }
  end
end
