class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates_uniqueness_of :name
  has_many :article_categories
  has_many :articles, through: :article_categories, dependent: :delete_all
end
