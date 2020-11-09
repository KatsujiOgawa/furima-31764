class AddCategoriesToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category_id, :integer, null:false
    add_column :items, :condition_id, :integer, null:false
    add_column :items, :shipping_payer_id, :integer, null:false
    add_column :items, :prefecture_id, :integer, null:false
    add_column :items, :shipping_days_id, :integer, null:false
  end
end
