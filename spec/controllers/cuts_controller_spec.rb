require 'spec_helper'

describe CutsController do
  let(:animal) { create :animal }
  let(:primal_cut) { create :primal_cut }
  subject { response }

  describe "GET 'index'" do
    context "animal id present" do
      before(:each) { get :index, animal_id: animal.to_param, :format => :json }

      its(:body)   { should_not be_empty }
      its(:status) { should be 200 }
    end

    context "primal cut id present" do
      before(:each) { get :index, primal_cut_id: primal_cut.to_param, :format => :json }

      its(:body)   { should_not be_empty }
      its(:status) { should be 200 }
    end
  end

  describe "POST 'create'" do
    context "animal id present" do
      context "correct params" do
        before(:each) { post :create, animal_id: animal.to_param, cut: attributes_for(:cut), format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) { post :create, animal_id: animal.to_param, cut: { name: nil }, format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    context "primal cut id present" do
      context "correct params" do
        before(:each) { post :create, primal_cut_id: primal_cut.to_param, cut: attributes_for(:cut), format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) { post :create, primal_cut_id: primal_cut.to_param, cut: { name: nil }, format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end
  end

  context "existing cut" do
    let(:cut) { create :cut }

    describe "GET 'show'" do
      before(:each) { get :show, :id => cut.to_param, :format => :json }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200 }

      context "with an unknown animal" do
        before(:each) { get :show, :id => 9999, :format => :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      context "with correct params" do
        before(:each) { put :update, id: cut.to_param, cut: { name: "Something new" }, format: :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 204 }

        it "updates the cut" do
          Cut.find(cut.id).name.should == "Something new"
        end
      end

      context "with bad params" do
        before(:each) { put :update, { id: cut.to_param, cut: { name: nil }, format: :json } }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) { delete :destroy, id: cut.to_param, :format => :json }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
