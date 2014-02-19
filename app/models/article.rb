class Article < ActiveRecord::Base
	belongs_to :user
	ARTICLE_CATEGORIES = {
		0 => "system",
		1 => "user content"
	}
end
