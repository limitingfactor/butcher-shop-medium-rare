class Cut < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :primal_cut
  belongs_to :animal
  has_many :favorites, dependent: :destroy

  validates :name, :presence => true
end
