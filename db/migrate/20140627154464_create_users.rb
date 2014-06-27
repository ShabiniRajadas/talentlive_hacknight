class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :role
      t.string :firstname
      t.string :lastname
      t.string :dob
      t.integer :age
      t.string :city
      t.string :country
      t.string :email
      t.string :password
      t.string :likes
      t.string :dislikes
      t.string :ambition
      t.string :talent
      t.string :aboutme
      t.string :gender
      t.string :gplus
      t.string :name
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.string :mobile
      t.string :hangouturl
      t.string :user_cloud_url
      t.timestamps
    end
  end
end