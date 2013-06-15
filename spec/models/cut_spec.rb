require 'spec_helper'

describe Cut do
  it { should be_a_kind_of ActiveModel::ForbiddenAttributesProtection }

  describe "associations" do
    it { should belong_to :animal }
    it { should belong_to :primal_cut }
    it { should have_many(:favorites).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end
end
