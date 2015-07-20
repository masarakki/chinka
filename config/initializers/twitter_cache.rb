Twitter::Cache.configure do |config|
  config.namespace = "chinka:#{Rails.env}"
  config.ttl = 15.minutes
  config.user_instance do |raw|
    OpenStruct.new(id: raw.id, screen_name: raw.screen_name,
                   name: raw.name, image: raw.profile_image_url_https(:original).to_s)
  end
end
