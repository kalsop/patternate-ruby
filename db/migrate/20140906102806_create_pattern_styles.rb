class CreatePatternStyles < ActiveRecord::Migration
  def self.up
    create_table :pattern_styles, :id => false do |t|
      t.integer :patterns_id
      t.integer :styles_id
    end

    add_index :pattern_styles, [:patterns_id, :styles_id]
  end

  def self.down
    drop_table :pattern_styles
  end
end
      
