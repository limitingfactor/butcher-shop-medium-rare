require 'spec_helper'

describe PrimalCut do
  it { should be_a_kind_of ActiveModel::ForbiddenAttributesProtection }

  it { should validate_presence_of :name }

  it { should have_many :cuts }
  it { should belong_to :animal }
end
