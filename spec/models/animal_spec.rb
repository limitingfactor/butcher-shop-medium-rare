
describe Animal do
  it { should be_a_kind_of ActiveModel::ForbiddenAttributesProtection }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should have_many :primal_cuts }
  it { should have_many :cuts }
end
