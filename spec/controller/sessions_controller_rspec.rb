require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user){FactoryBot.create :user}
  
  describe "GET #new" do
    before{get :new}

    context "Return to success response" do
      it{expect(response.status).to eq 200}
    end

    context "Render login template" do
      it{expect(response).to render_template :new}
    end
  end

  describe "POST #create" do 
    describe "Login success" do
      before{post :create, params:{session:{email: user.email, password: user.password, remember_me: 0}}}

      context "Return to success response" do
        it{expect(response.status).to eq 302}
      end

      context "Check login success" do
        it{expect(session[:user_id]).to eq user.id}
      end

      context "Check remember" do
        it{expect(cookies.permanent[:remember_token]).to eq user.remember_token}
      end

      context "Redirect to home page" do
        it{expect(response).to redirect_to root_url}
      end
    end

    describe "Login fail" do
      context "Invalid email" do
        before{post :create, params:{session:{email: nil, password: "123456", remember_me: 0}}}
  
        it{expect(response).to render_template :new}
      end
  
      context "Invalid password" do
        before{post :create, params:{session:{email: user.email, password: nil, remember_me: 0}}}
  
        it{expect(response).to render_template :new}
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user){FactoryBot.create :user}

    describe "Logout success" do
      before do
        post :create, params:{session:{email: user.email, password: user.password, remember_me: 0}}
        delete :destroy, params:{id: user.id}
      end

      context "Check logout" do
        it{expect(session[:user_id]).to be_nil}
      end

      context "Check remember" do
        it{expect(cookies.permanent[:remember_token]).to be_nil}
      end

      context "Redirect to home page" do
        it{expect(response).to redirect_to root_path}
      end
    end

    describe "Logout fail (Not login)" do
      before{delete :destroy, params:{id: user.id}}

      context "Redirect to page login" do
        it{expect(response).to redirect_to root_path}
      end
    end
  end
end
