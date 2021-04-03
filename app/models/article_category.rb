class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category

  scope :category_article_count, lambda {|category_id| where("category_id = ?", category_id).select(:category_id).uniq }
end

