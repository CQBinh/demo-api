module V1
	class BookAPI < Grape::API
		resource :books do

      desc "Add new book."
      params do
        requires :title, type: String
        requires :description, type: String
        requires :price, type: Integer
      end
      post "/add", rabl: "books/add" do
        ActiveRecord::Base.transaction do
          @book = Book.add(converted_params)
        end
      end

      desc "List all books"
      get "/all", rabl: "books/all" do
      	ActiveRecord::Base.transaction do
      		@books = Book.all()
      	end
      end

      desc "Get book by id",{
        headers: {
          "Access-Token" => { description: "Access-Token", required: true }
        }
      }
      get '/:id', rabl: "books/show" do
      	ActiveRecord::Base.transaction do
      		authenticate!
      		@book = Book.find(params[:id])
      	end
      end

		end
	end
end