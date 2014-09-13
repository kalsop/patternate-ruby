class RenamePatternStylesColumnsStyles < ActiveRecord::Migration
  def self.up
       rename_column :patterns_styles, :styles_id, :style_id
  end
  def self.down
       rename_column :patterns_styles, :style_id, :styles_id
  end
end
