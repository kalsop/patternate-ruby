class AddPatternName < ActiveRecord::Migration
  def change
        add_column(:patterns, :pattern_name, :string)
  end
end
