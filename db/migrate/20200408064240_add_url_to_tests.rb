class AddUrlToTests < ActiveRecord::Migration[5.1]
  def change
    add_column :tests, :url, :string
  end
end
