class AddTimezoneToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :timezone, :string
  end
end
