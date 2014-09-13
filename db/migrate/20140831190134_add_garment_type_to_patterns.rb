class AddGarmentTypeToPatterns < ActiveRecord::Migration
  def change
        add_column(:patterns, :garment_type, :integer)
  end
end
