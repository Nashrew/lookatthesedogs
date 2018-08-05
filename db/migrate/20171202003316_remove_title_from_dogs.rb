class RemoveTitleFromDogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :dogs, :title, :string
  end
end
