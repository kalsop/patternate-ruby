class DropGarmentType < ActiveRecord::Migration
  def change
    drop_table :garment_type
  end
end
