class Event < ActiveRecord::Base
	has_many :user_events
	has_many :users, :through => :user_events
	validates :category, :presence => true

	mount_uploader :cover_pic_url, ImageUploader
end
