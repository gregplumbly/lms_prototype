class CreateVideoProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :video_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.integer :current_time
      t.integer :duration
      t.boolean :completed
      t.datetime :last_watched_at

      t.timestamps
    end
  end
end
