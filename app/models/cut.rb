class Cut < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :primal_cut
  belongs_to :animal

  validates :name, :presence => true
end
