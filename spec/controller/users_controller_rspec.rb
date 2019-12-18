require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    before{get :new}

    context "Return to success response" do
      it{expect(response.status).to eq 200}
    end

    context "Render sign up template" do
      it{expect(response).to render_template :new}
    end
  end

  describe "POST #create" do
    let!(:user){FactoryBot.create :user, email: "asd@gmail.com"}

    describe "Valid attributes" do
      before{post :create, params:{user: FactoryBot.attributes_for(:user, email: "abcd@gmail.com")}}
      
      context "Create user success" do
        it{expect(User.count).to eq 2}
      end

      context "Redirect to login" do
        it{expect(response).to redirect_to login_path}
      end
    end

    describe "Invalid attributes" do
      before{post :create, params:{user: FactoryBot.attributes_for(:user, email: "asd@gmail.com")}}

      context "Render sign up template" do
        it{expect(response).to render_template :new}
      end
    end
  end

  describe "Params" do
    context "User params" do
      params = {user: {name: "minh", email: "asd@gmail.com",
        password: "123456", password_confirmation: "123456"}}
      it{should permit(:name, :email, :password, :password_confirmation).for(:create, params: params).on(:user)}
    end
  end
end
