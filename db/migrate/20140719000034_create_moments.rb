class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :body
      t.integer :score

      t.timestamps
    end
  end
end
