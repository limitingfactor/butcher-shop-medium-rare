require 'spec_helper'

describe FavoritesController do
  let(:user) { create(:user) }
  subject { response }

  describe "GET 'index'" do
    before(:each) { get :index, user_id: user.to_param, :format => :json }

    its(:body)   { should_not be_empty }
    its(:status) { should be 200}
  end

  describe "POST 'create'" do
    context "user id present" do
      context "correct params" do
        before(:each) { post :create, user_id: user.to_param, favorite: attributes_for(:favorite), format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 201 }
        its(:headers) { should include "Location" }
      end

      context "with bad params" do
        before(:each) { post :create, user_id: user.to_param, favorite: { cut_id: nil }, format: :json }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end
  end

  context "existing favorite" do
    let(:favorite) { create :favorite }

    describe "GET 'show'" do
      before(:each) { get :show, id: favorite.to_param, format: :json }

      its(:body)    { should_not be_empty }
      its(:status)  { should be 200 }

      context "with an unknown favorite" do
        before(:each) { get :show, id: 9999, format: :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 404 }
      end
    end

    describe "PUT 'update'" do
      context "with correct params" do
        before(:each) { put :update, id: favorite.to_param, favorite: { cut_id: 5 }, format: :json }

        its("body.strip") { should be_empty }
        its(:status)      { should be 204 }

        it "updates the favorite" do
          Favorite.find(favorite.id).cut_id.should == 5
        end
      end

      context "with bad params" do
        before(:each) { put :update, { id: favorite.to_param, favorite: { cut_id: nil }, format: :json } }

        its(:body)    { should_not be_empty }
        its(:status)  { should be 422 }
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) { delete :destroy, id: favorite.to_param, format: :json }

      its("body.strip") { should be_empty }
      its(:status)      { should be 204 }
    end
  end
end
