class CreateAggregatorConfigurations < ActiveRecord::Migration
  def change
    create_table :aggregator_configurations do |t|
      t.string :source
      t.text :feed_object
    end
  end
end
