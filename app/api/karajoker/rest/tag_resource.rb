module Karajoker
    module Rest
        class TagResource < Grape::API
            desc 'Tag CRUD'
            resource :tags do
                desc 'Add new tag'
                params do
                    requires :name, type: String, desc: 'A tab name'
                end
                post do
                    Tag.create(name: params[:name])
                end

                desc 'Get all tags'
                get do
                    Tag.all
                end
            end
        end
    end
end
