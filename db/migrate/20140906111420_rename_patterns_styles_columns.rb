class RenamePatternsStylesColumns < ActiveRecord::Migration
def self.up
    rename_column :patterns_styles, :patterns_id, :pattern_id
  
  end

def self.down
    rename_column :patterns_styles, :pattern_id, :patterns_id

  end
end
