class TwitterUser
  include ActiveModel::Model
  attr_accessor :id, :screen_name, :name, :image

  def self.from_raw(raw)
    new(id: raw.id, screen_name: raw.screen_name,
        name: raw.name, image: raw.profile_image_url_https(:original).to_s)
  end
end

Twitter::Cache.configure do |config|
  config.namespace = "chinka:#{Rails.env}"
  config.ttl = 15.minutes
  config.user_instance do |raw|
    TwitterUser.from_raw(raw)
  end
end
