class RemoveDescAndNonCountrFromDogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :dogs, :descr, :string
    remove_column :dogs, :non_count, :integer
  end
end
