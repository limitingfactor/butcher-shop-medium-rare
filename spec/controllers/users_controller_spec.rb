require 'spec_helper'

describe UsersController do
  let(:user_attrs)     { { :format => :json, :user => attributes_for(:user) } }
  let(:bad_user_attrs) { { :format => :json, :user => { :first_name => "Test" } } }
  subject              { response }

  describe "GET 'index'" do
    before(:each) { get :index, :format => :json }

    its(:body)   { should_not be_empty }
    its(:status) { should be 200}
  end

  describe "POST 'create'" do
    before(:each) { post :create, user_attrs }

    its(:body)    { should_not be_empty }
    its(:status)  { should be 201 }
    its(:headers) { should include "Location" }

    context "with bad params" do
      before(:each) { post :create, bad_user_attrs }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 422 }
    end
  end

  context "existing user" do
    let!(:user)      { create :user }
    let(:user_attrs) { { :id => user.id, :format => :json, :user => { :first_name => "Slicey" } } }

    describe "GET 'show'" do
      before(:each) { get :show, :id => user.id, :format => :json }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200}

      context "with an unknown user" do
        before(:each) { get :show, :id => 9999, :format => :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      before(:each) { put :update, user_attrs }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }

      it "updates the user" do
        User.find(user.id).first_name.should eq user_attrs[:user][:first_name]
      end

      context "with bad params" do
        before(:each) { put :update, { :id => user.id, :user => { :first_name => nil }, :format => :json } }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) { delete :destroy, :id => user.id, :format => :json }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
