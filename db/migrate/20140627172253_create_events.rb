class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :about
      t.text :rules
      t.string :first_prize_info
      t.string :second_prize_info
      t.string :third_prize_info
      t.string :category
      t.datetime :audition_start_datetime
      t.datetime :audition_end_datetime
      t.string :cover_pic_url
      t.timestamps
    end
  end
end
