class API < Grape::API
  prefix 'api'
  format :json
  mount Resource::KaraokeResource
  mount Resource::TagResource

  helpers do
    def logger
      API.logger
    end
  end
end
