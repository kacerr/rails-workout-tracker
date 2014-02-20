class UserMeasurement < ActiveRecord::Base
	belongs_to :user
	belongs_to :measurement

	default_scope order: 'date DESC'
	validates :value, numericality: true


	attr_accessor :unix_date
end
