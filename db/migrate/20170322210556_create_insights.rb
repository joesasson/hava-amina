class CreateInsights < ActiveRecord::Migration[5.1]
  def change
    create_table :insights do |t|
      t.string :text

      t.timestamps
    end
  end
end
