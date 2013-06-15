class PrimalCut < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :animal
  has_many :cuts

  validates :name, presence: true
end
