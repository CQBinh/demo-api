class Book < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true
	validates :price, presence: true

  def self.add(params)
    @book = create!(permit_add_book_params(params))
    @book
  end

  private
  
  def self.permit_add_book_params(params)
      params.permit(:title, :description, :price)
  end
end
