class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :vocab, null: false
      t.text :definition, null: false
      t.text :example, null: false
      t.text :image, null: false
      t.timestamps
    end
  end
end
