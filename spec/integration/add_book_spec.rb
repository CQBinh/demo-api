require 'airborne'
require 'active_support'

Airborne.configure do |config|
	config.base_url = 'http://localhost:3000/api/v1'
end

describe 'Add book' do
		before do
			@title = "Demo title"
			@description = "Demo description"
			@price = 100000
			@access_token_hash = {'Access-Token' => 'foo'}
			@post_add_book_path = '/books/add'
		end

		it "failed cause by missing access_token" do
			post @post_add_book_path, {}
			expect_json('meta', {status: "failed", code: 401})
			expect_json_types(data: :null)
		  expect_json_types('meta', {messages: :string})
		end

		it "failed cause by wrong access_token" do
			wrong_access_token = {'Access-Token' => 'this is wrong access_token'}
			post @post_add_book_path, {}, wrong_access_token
			expect_json('meta', {status: "failed", code: 401})
			expect_json_types(data: :null)
		  expect_json_types('meta', {messages: :string})
		end

		it "failed cause by missing title" do
			book = {price: @price, description: @description}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*title.*")})
		end

		it "failed cause by missing price" do
			book = {title: @title, description: @description}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*price.*")})
		end

		it "failed cause by missing description" do
			book = {title: @title, price: @price}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*description.*")})
		end

		it "failed cause by missing title and price" do
			book = {description: @description}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*title.*price.*")})
		end

		it "failed cause by missing title and description" do
			book = {price: @price}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*title.*description.*")})
		end

		it "failed cause by missing description and price" do
			book = {title: @title}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			expect_json('meta', {messages: regex(".*description.*price.*")})
		end

		it "failed cause by missing title, description and price" do
			book = {}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "missing_params", code: 405})
			pattern = ".*title.*.*description.*price.*"
			expect_json('meta', {messages: regex(pattern)})
		end

		it "success" do
			now = DateTime.now
			book = {title: "#{@title}#{now}", description: @description, price: @price}
			post @post_add_book_path, book, @access_token_hash
			expect_json('meta', {status: "successfully", code: 200})
			expect_json_types(data: :object)
			expect_json_types('data', {title: :string, description: :string})
		end

end