require 'grape'

module Rest::Entity
  class TagDetail < Grape::Entity
    expose :name, documentation: { type: 'string', desc: 'The name of tag' }
  end
end
