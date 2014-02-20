class UserMeasurement < ActiveRecord::Base
	belongs_to :user
	belongs_to :measurement

	validates :value, numericality: true


	attr_accessor :unix_date
end
