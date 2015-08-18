module V1
	class BookAPI < Grape::API
		resource :books do

      desc "Add new book."
      params do
        requires :title, type: String, description: "The book's title"
        requires :description, type: String
        requires :price, type: Integer, description: "The book's price"
      end
      post "/add", rabl: "books/add" do
        ActiveRecord::Base.transaction do
          @book = Book.add(converted_params)
        end
      end

      desc "List all books",{
        headers: {
          "Access-Token" => { description: "Access-Token", required: true }
        }
      }
      get "/all", rabl: "books/all" do
        authenticate!
      	ActiveRecord::Base.transaction do
      		@books = Book.all()
      	end
      end

      desc "Get book by id"
      get '/:id', rabl: "books/show" do
      	ActiveRecord::Base.transaction do
      		@book = Book.find(params[:id])
      	end
      end

		end
	end
end