require 'spec_helper'

describe AnimalsController do
  let(:animal_attrs)     { { :format => :json, :animal => attributes_for(:animal) } }
  let(:bad_animal_attrs) { { :format => :json, :animal => { :name => nil } } }
  subject                { response }

  describe "GET 'index'" do
    before(:each) { get :index, :format => :json }

    its(:body)   { should_not be_empty }
    its(:status) { should be 200}
  end

  describe "POST 'create'" do
    before(:each) { post :create, animal_attrs }

    its(:body)    { should_not be_empty }
    its(:status)  { should be 201 }
    its(:headers) { should include "Location" }

    context "with bad params" do
      before(:each) { post :create, bad_animal_attrs }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 422 }
    end
  end

  context "existing animal" do
    let!(:animal)      { create :animal }
    let(:animal_attrs) { { :id => animal.id, :format => :json, :animal => { :name => "Super Chicken" } } }

    describe "GET 'show'" do
      before(:each) { get :show, :id => animal.id, :format => :json }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200}

      context "with an unknown animal" do
        before(:each) { get :show, :id => 9999, :format => :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      before(:each) { put :update, animal_attrs }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }

      it "updates the animal" do
        Animal.find(animal.id).name.should eq animal_attrs[:animal][:name]
      end

      context "with bad params" do
        before(:each) { put :update, { :id => animal.id, :animal => { :name => nil }, :format => :json } }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) { delete :destroy, :id => animal.id, :format => :json }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
