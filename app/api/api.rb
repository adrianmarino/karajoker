class API < Grape::API
  prefix 'api'
  format :json
  mount Karajoker::Rest::Resource::KaraokeResource
  mount Karajoker::Rest::Resource::TagResource
  mount Karajoker::Rest::Resource::IndexResource

  helpers do
    def logger
      API.logger
    end
  end
end
