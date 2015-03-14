class API < Grape::API
    prefix 'api'
    format :json
    mount Karajoker::Rest::KaraokeResource
    mount Karajoker::Rest::TagResource

    helpers do
        def logger
            API.logger
        end
    end
end
