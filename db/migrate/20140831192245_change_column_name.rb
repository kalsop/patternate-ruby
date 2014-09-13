class ChangeColumnName < ActiveRecord::Migration
def self.up
    rename_column :patterns, :garment_type, :garment_type_id
  end
end
