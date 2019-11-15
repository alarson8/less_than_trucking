class CreateRandomFulfillment < ActiveRecord::Migration[5.2]
  def change
    create_table :random_fulfillments do |t|
      t.boolean :best_capacity, default: false, null: false
      t.boolean :best_deliveries, default: false, null: false
      t.jsonb :log, default: "{}", null: false
      t.integer :deliveries, null: false
      t.integer :remaining_capacity, null: false
      t.float :average_equal_distribution
      t.integer :seconds_since_epoch
      t.timestamps
    end
  end
end
