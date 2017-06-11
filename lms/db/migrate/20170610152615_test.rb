class Test < ActiveRecord::Migration[5.0]
  def change
    create_table :test1 do |t|
      t.string    :title
      t.string    :image
      t.string    :video
      t.integer   :roll_no
      t.float     :price
      t.boolean   :correct_answer
      t.timestamps
    end
    create_table :test2 do |t|
      t.string  :title
      t.text    :description
      t.string  :image
      t.boolean :gender
      t.timestamps
      t.datetime :birthdate
    end

    add_reference :test2, :test1, foreign_key: true
  end
end
