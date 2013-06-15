class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :cut_id

  has_one :cut
end
