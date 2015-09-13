class API < Grape::API
  prefix 'api'
  format :json
  mount Rest::Resource::KaraokeResource
  mount Rest::Resource::TagResource
  mount Rest::Resource::IndexResource

  helpers do
    def logger
      API.logger
    end
  end
end
