class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true,
                         :uniqueness => true
end
