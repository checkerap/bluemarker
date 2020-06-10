class AddTimespanToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :timespan, :integer
  end
end
