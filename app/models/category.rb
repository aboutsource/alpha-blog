class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  validates_uniqueness_of :name
  has_and_belongs_to_many :articles, join_table: :article_categories
end
