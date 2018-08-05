class CreateDogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dogs do |t|
      t.string :title
      t.text :descr
      t.string :image
      t.integer :non_count

      t.timestamps
    end
  end
end
