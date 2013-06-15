require 'spec_helper'

describe Animal do
  it { should be_a_kind_of ActiveModel::ForbiddenAttributesProtection }

  describe "associations" do
    it { should have_many(:primal_cuts).dependent(:destroy) }
    it { should have_many(:cuts).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end
