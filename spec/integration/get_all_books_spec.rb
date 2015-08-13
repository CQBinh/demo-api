require 'airborne'
require 'active_support'

Airborne.configure do |config|
	config.base_url = 'http://localhost:3000/api/v1'
end

describe 'Get all books' do
	before do
		@post_get_all_book_path = '/books/all'
		@access_token_hash = {'Access-Token' => 'foo'}
	end

	it 'failed cause by missing access_token' do
		get @post_get_all_book_path
		expect_status 401
		expect_json('meta', {status: "failed", code: 401})
		expect_json_types({data: :null})
	  expect_json_types('meta', {messages: :string})
	end

	it 'failed cause by wrong access_token' do
		wrong_access_token = {'Access-Token' => 'this is wrong access_token'}
		get @post_get_all_book_path, wrong_access_token
		expect_status 401
		expect_json('meta', {status: "failed", code: 401})
		expect_json_types({data: :null})
	  expect_json_types('meta', {messages: :string})
	end

	it 'success' do
		get @post_get_all_book_path, @access_token_hash
		expect_status 200
		expect_json_types(data: :object, meta: :object)
		expect_json_types('data', :object)
		expect_json_types('data', {books: :array_of_objects})
		expect_json_types('data.books', :array)
		expect_json_types('data.books.0', {title: :string, description: :string})
		expect_json_types('data.books.*', {title: :string, description: :string})
		expect_json_types('data.books.0.title', :string)
	end

end