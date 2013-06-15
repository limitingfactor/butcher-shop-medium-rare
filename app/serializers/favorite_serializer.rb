class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :cut_id
end
