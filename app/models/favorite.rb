class Favorite < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  belongs_to :cut

  validates :cut_id, presence: true
end
