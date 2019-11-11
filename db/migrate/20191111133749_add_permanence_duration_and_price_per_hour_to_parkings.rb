class AddPermanenceDurationAndPricePerHourToParkings < ActiveRecord::Migration[5.2]
  def change
    add_column :parkings,:permanence_duration, :integer, default: 0
    add_column :parkings,:price_per_hour, :float, default: 0.00

  end
end
