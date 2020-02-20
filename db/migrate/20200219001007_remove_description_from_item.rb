class RemoveDescriptionFromItem < ActiveRecord::Migration[6.0]

  def up
    remove_column :items, :Description, :text
  end

  def down
    add_column :items, :Description, :text
  end
end
