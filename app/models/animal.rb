class Animal < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :primal_cuts, :dependent => :destroy
  has_many :cuts,        :dependent => :destroy

  validates :name, :presence   => true,
                   :uniqueness => true
end
