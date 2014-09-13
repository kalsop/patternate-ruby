class DropPatternFor < ActiveRecord::Migration
  def change
    drop_table :pattern_for
  end
end
