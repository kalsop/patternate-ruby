class RenamePatternStyles < ActiveRecord::Migration
  def self.up
    rename_table :pattern_styles, :patterns_styles
  end

 def self.down
    rename_table :patterns_styles, :pattern_styles
 end
end