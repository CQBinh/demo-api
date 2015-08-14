object @book => :book
	extends "books/_book"
  node :cheap_book do |book| 
  	book.price < 1_000_000
end