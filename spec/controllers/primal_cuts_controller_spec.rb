require 'spec_helper'

describe PrimalCutsController do
  let(:animal) { build(:animal, id: 50) }
  let(:primal_cut) { create(:primal_cut, id: 60) }
  subject { response }

  describe "GET 'index'" do
    before(:each) do
      mock_primal_cut = mock("PrimalCut")
      Animal.should_receive(:find).with(animal.to_param).and_return(animal)
      animal.should_receive(:primal_cuts).and_return(mock_primal_cut)
      mock_primal_cut.should_receive(:as_json)
      get :index, animal_id: animal.to_param, format: :json
    end

    its(:body)   { should_not be_empty }
    its(:status) { should be 200 }
  end

  describe "POST 'create'" do
    context "animal id present" do
      context "correct params" do
        before(:each) do
          mock_primal_cut = mock("PrimalCut")
          Animal.should_receive(:find).with(animal.to_param).and_return(animal)
          animal.should_receive(:primal_cuts).and_return(mock_primal_cut)
          mock_primal_cut.should_receive(:create).with({ "name" => "filet" }).and_return(primal_cut)
          post :create, animal_id: animal.to_param, primal_cut: attributes_for(:primal_cut), format: :json
        end

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) do
          mock_primal_cut = mock("PrimalCut")
          Animal.should_receive(:find).with(animal.to_param).and_return(animal)
          animal.should_receive(:primal_cuts).and_return(mock_primal_cut)
          mock_primal_cut.should_receive(:create).with({ "name" => nil }).and_return(mock_primal_cut)
          mock_primal_cut.should_receive(:errors).twice.and_return({"something" => "is wrong"})
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
        PrimalCut.should_receive(:find).with(primal_cut.to_param).and_return(primal_cut)
        get :show, id: primal_cut.to_param, format: :json
      end

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200 }

      context "with an unknown primal_cut" do
        before(:each) do
          PrimalCut.should_receive(:find).with("9999").and_raise(ActiveRecord::RecordNotFound)
          get :show, id: 9999, format: :json
        end

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      context "with correct params" do
        before(:each) do
          PrimalCut.should_receive(:find).with(primal_cut.to_param).and_return(primal_cut)
          primal_cut.should_receive(:update_attributes).with({"name" => "Something new"}).and_return(true)
          put :update, id: primal_cut.to_param, primal_cut: { name: "Something new" }, format: :json
        end

        its("body.strip") { should be_empty }
        its(:status)      { should be 204 }
      end

      context "with bad params" do
        before(:each) do
          PrimalCut.should_receive(:find).with(primal_cut.to_param).and_return(primal_cut)
          primal_cut.should_receive(:update_attributes).with({"name" => "nil"}).and_return(false)
          primal_cut.should_receive(:errors).twice.and_return({"something" => "is wrong"})
          put :update, id: primal_cut.to_param, primal_cut: { name: "nil" }, format: :json
        end

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        PrimalCut.should_receive(:find).with(primal_cut.to_param).and_return(primal_cut)
        primal_cut.should_receive(:destroy)
        delete :destroy, id: primal_cut.to_param, format: :json
      end

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
