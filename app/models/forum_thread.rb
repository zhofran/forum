class ForumThread < ApplicationRecord
	extend FriendlyId

	friendly_id :title, use: :slugged

	belongs_to :user
	has_many :forum_post, dependent: :destroy

	validates :title, presence: true, length: {maximum: 50} 
	validates :content, presence: true

	def sticky
		sticky_order < 100
	end

	def pins
		self.sticky_order = 1
		self.save
	end
end
