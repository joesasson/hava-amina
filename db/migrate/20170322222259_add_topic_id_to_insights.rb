class AddTopicIdToInsights < ActiveRecord::Migration[5.1]
  def change
    add_column :insights, :topic_id, :integer
  end
end
