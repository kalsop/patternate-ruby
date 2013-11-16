class FixDefault < ActiveRecord::Migration
  
  def self.up
    change_table "patterns" do |t|
      t.change "pattern_collection_id", :integer, null: true
    end 
  end
end