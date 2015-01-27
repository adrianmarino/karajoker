module Resource
	class KaraokeResource < Grape::API
		desc 'Karaoke CRUD'
		resource :karaokes do

			desc 'Add new karaoke'
			params do
				requires :title, type: String, desc: 'A karaoke title'
				requires :youtube_id, type: String, desc: 'A karaoke youtube identifier'
			end
			post do
				Karaoke.create_from params
			end

			desc 'Get all karaokes'
			get do
				Karaoke.all
			end

			desc 'Find karaokes'
			params do
				requires :query, type: String, desc: 'A query'
			end			
			get '/search/:query' do
				@results = Karaoke.search params[:query]
				present @results, with: Entities::KaraokeDetail
			end
			
			desc 'Remove a karaoke'
			params do
				requires :id, type: Integer, desc: 'A karaoke identifier'
			end
			delete ':id' do
				Karaoke.destroy params[:id]
			end
		end
	end
end

