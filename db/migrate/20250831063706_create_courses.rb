class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :slug
      t.boolean :published

      t.timestamps
    end
  end
end
