require 'spec_helper'

describe PrimalCutsController do
  let(:animal) { create :animal }
  subject { response }

  describe "GET 'index'" do
    before(:each) { get :index, animal_id: animal.to_param, format: :json }

    its(:body)   { should_not be_empty }
    its(:status) { should be 200 }
  end

  describe "POST 'create'" do
    context "animal id present" do
      context "correct params" do
        before(:each) { post :create, animal_id: animal.to_param, primal_cut: attributes_for(:primal_cut), format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) { post :create, animal_id: animal.to_param, primal_cut: { name: nil }, format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end
  end

  context "existing primal cut" do
    let(:primal_cut) { create :primal_cut }

    describe "GET 'show'" do
      before(:each) { get :show, id: primal_cut.to_param, format: :json }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200 }

      context "with an unknown primal_cut" do
        before(:each) { get :show, id: 9999, format: :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      context "with correct params" do
        before(:each) { put :update, id: primal_cut.to_param, primal_cut: { name: "Something new" }, format: :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 204 }

        it "updates the primal_cut" do
          PrimalCut.find(primal_cut.id).name.should == "Something new"
        end
      end

      context "with bad params" do
        before(:each) { put :update, { id: primal_cut.to_param, primal_cut: { name: nil }, format: :json } }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) { delete :destroy, id: primal_cut.to_param, format: :json }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
