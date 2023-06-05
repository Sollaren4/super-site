class User < ApplicationRecord
	has_secure_password

	before_save :downcase_nickname

	has_many :articles
	has_many :comments

	validates :email, presence: true, uniqueness: true

	def downcase_nickname
		nickname.downcase!
	end
end
