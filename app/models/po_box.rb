class PoBox < ActiveRecord::Base
  has_many :users
  validates :box_number, presence: true
  validates :city, presence: true
  validates :country, presence: true

  def self.search(query)
    where("box_number ilike ? OR city ilike ? OR country ilike ?",
    "%#{query}%",
    "%#{query}%",
    "%#{query}%")
  end

end
