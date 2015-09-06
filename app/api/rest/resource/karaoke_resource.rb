module Rest::Resource
  class KaraokeResource < Grape::API
    KaraokeDetail = Rest::Entity::KaraokeDetail

    desc 'Karaoke CRUD'
    resource :karaokes do
      desc 'Add new karaoke'
      params do
        requires :title, type: String, desc: 'A karaoke title'
        requires :youtube_id, type: String, desc: 'A karaoke youtube identifier'
      end
      post { Karaoke.create_from params }

      desc 'Get all karaokes'
      get { present Karaoke.all, with: KaraokeDetail }

      desc 'Find karaokes'
      params { requires :query, type: String, desc: 'A query' }
      get '/search/:query' do
        @results = Karaoke.search params[:query]
        present @results, with: KaraokeDetail
      end

      desc 'Remove a karaoke'
      params { requires :id, type: Integer, desc: 'A karaoke identifier' }
      delete ':id' do
        Karaoke.destroy params[:id]
      end
    end
  end
end
