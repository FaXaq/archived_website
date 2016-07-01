# coding: utf-8
class Post < ActiveRecord::Base
  validates :title, uniqueness: true, presence: true
  validates :slug, uniqueness: true, presence: true
  validates :description, presence: true
  validates :content, presence: true
  def self.search(search)
    if search
      where(published: true).where('title LIKE ?', "%#{search}%").reverse
    else
      where(published: true).last(5).reverse
    end
  end
end
