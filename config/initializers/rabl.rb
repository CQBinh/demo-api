class PrettyJson
  def self.dump(object)
    JSON.pretty_generate(object, indent: "    ")# tu tu chu se hieu
  end
end

Rabl.configure do |config|
  config.json_engine = PrettyJson if Rails.env.development?
  config.include_json_root = false
end
