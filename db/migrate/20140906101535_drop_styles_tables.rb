class DropStylesTables < ActiveRecord::Migration
  def change
    drop_table :styles
    drop_table :patterns_styles
  end
end
