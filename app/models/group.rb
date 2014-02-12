class Group < ActiveRecord::Base
	validates :name, presence:   true
  has_many :memberships, :dependent => :destroy
 	has_many :users, :through => :memberships
	def is_empty?


	end
end
