require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    context "when user is not signed in" do
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      it "returns a successful response" do
        user = User.create(email: "test@example.com", password: "password123")
        sign_in user
        get :index
        expect(response).to be_redirect
      end
    end
  end
end