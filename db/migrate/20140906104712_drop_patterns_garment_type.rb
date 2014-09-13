class DropPatternsGarmentType < ActiveRecord::Migration
  def change
    drop_table :patterns_garment_type
  end
end
