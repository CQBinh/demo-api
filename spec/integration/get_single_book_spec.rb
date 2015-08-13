require 'airborne'
require 'active_support'

Airborne.configure do |config|
	config.base_url = 'http://localhost:3000/api/v1'
end

describe 'Single book' do
	before do
		@post_get_single_book_path = '/books/'
		@access_token_hash = {'Access-Token' => 'foo'}
	end

	it 'get first book failed cause by missing access_token' do
		get "#{@post_get_single_book_path}1"
		expect_status 401
		expect_json('meta', {status: "failed", code: 401})
		expect_json_types(data: :null)
	  expect_json_types('meta', {messages: :string})
	end

	it 'get first book failed cause by wrong access_token' do
		wrong_access_token = {'Access-Token' => 'this is wrong access_token'}
		get "#{@post_get_single_book_path}1", wrong_access_token
		expect_status 401
		expect_json('meta', {status: "failed", code: 401})
		expect_json_types(data: :null)
	  expect_json_types('meta', {messages: :string})
	end

	it 'get book failed cause by providing invalid id' do
		get "#{@post_get_single_book_path}-1", @access_token_hash
		expect_status 404
		expect_json('meta', {status: "failed", code: 404})
		expect_json_types(data: :null)
	  expect_json_types('meta', {messages: :string})
	end

	it 'get book failed cause by providing out of range id' do
		get "#{@post_get_single_book_path}99999999999", @access_token_hash
		expect_status 404
		expect_json('meta', {status: "failed", code: 404})
		expect_json_types(data: :null)
	  expect_json_types('meta', {messages: :string})
	end

	it 'get book success' do
		get "#{@post_get_single_book_path}1", @access_token_hash
		expect_status 200
		expect_json('meta', {status: "successfully", code: 200})
		expect_json_types(data: :object)
		data_structe = {title: :string, description: :string, cheap_book: :boolean}
		expect_json_types('data', data_structe)
	end

end