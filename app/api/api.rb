class API < Grape::API
  prefix 'api'
  format :json
  mount Resource::KaraokeResource

  helpers do
    def logger
      API.logger
    end
  end
end
