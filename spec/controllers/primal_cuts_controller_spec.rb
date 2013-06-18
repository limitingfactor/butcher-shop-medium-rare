require 'spec_helper'

describe PrimalCutsController do
  let(:animal) { build(:animal, id: 50) }
  let(:primal_cut) { build(:primal_cut, id: 60) }
  subject { response }

  describe "collection actions" do
    before(:each) { Animal.stub(:find).and_return(animal) }

    describe "GET 'index'" do
      before(:each) do
        animal.should_receive(:primal_cuts)
        get :index, animal_id: animal.to_param, format: :json
      end

      its(:body)   { should_not be_empty }
      its(:status) { should be 200 }
    end

    describe "POST 'create'" do
      context "correct params" do
        before(:each) do
          PrimalCut.should_receive(:create).and_return(primal_cut)
          post :create, animal_id: animal.to_param, primal_cut: attributes_for(:primal_cut), format: :json
        end

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) do
          post :create, animal_id: animal.to_param, primal_cut: { name: nil }, format: :json
        end

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end
  end

  context "existing primal cut" do
    describe "GET 'show'" do
      before(:each) do
        PrimalCut.stub(:find).and_return(primal_cut)
        get :show, id: primal_cut.to_param, format: :json
      end

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200 }

      context "with an unknown primal_cut" do
        before(:each) do
          PrimalCut.stub(:find).and_raise(ActiveRecord::RecordNotFound)
          get :show, id: 9999, format: :json
        end

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      context "with correct params" do
        before(:each) do
          PrimalCut.stub(:find).and_return(primal_cut)
          primal_cut.should_receive(:update_attributes)
          put :update, id: primal_cut.to_param, primal_cut: { name: "Something New" }, format: :json
        end

        its("body.strip") { should be_empty }
        its(:status)      { should be 204 }
      end

      context "with bad params" do
        before(:each) do
          PrimalCut.stub(:find).and_return(primal_cut)
          put :update, id: primal_cut.to_param, primal_cut: { name: nil }, format: :json
        end

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        PrimalCut.stub(:find).and_return(primal_cut)
        primal_cut.should_receive(:destroy)
        delete :destroy, id: primal_cut.to_param, format: :json
      end

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
