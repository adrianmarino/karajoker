module Resource
	class KaraokeResource < Grape::API
		desc 'Karaoke CRUD'
		resource :karaokes do
			desc 'Add new Karaoke'
			params do
				requires :title, type: String, desc: 'A karaoke title'
				requires :youtube_id, type: String, desc: 'A karaoke youtube identifier'
			end
			post do
				Karaoke.create(title:params[:title], youtube_id: params[:youtube_id])
			end

			desc 'Get all Karaokes'
			get do
				Karaoke.all
			end
		end
	end
end
