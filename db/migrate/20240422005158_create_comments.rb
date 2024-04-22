class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :post_id
      t.string :user_id

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
