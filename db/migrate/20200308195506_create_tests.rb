class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.string :state
      t.string :error
      t.json :results

      t.timestamps
    end
  end
end
