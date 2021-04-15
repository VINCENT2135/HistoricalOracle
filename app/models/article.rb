class Article < ApplicationRecord
    belongs_to :user
	 
    has_many :article_categories, dependent: :destroy 
    has_many :categories, through: :article_categories
	 
	 has_many :comments, dependent: :destroy
    
    validates :title , presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}

	 scope :user_article_count, lambda {|user_id| where("user_id = ?", user_id).select(:user_id).uniq }
     accepts_nested_attributes_for :categories          
end


