require 'spec_helper'

describe Favorite do
  it { should be_a_kind_of ActiveModel::ForbiddenAttributesProtection }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:cut) }
  end

  describe "validations" do
    it { should validate_presence_of(:cut_id) }
  end
end
