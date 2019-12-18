require 'rails_helper'

RSpec.describe HistoryController, type: :controller do
  describe "GET #index" do
    let!(:user){FactoryBot.create :user_with_chapter, email: "bcd@gmail.com"}
    before{get :index}

    describe "User login" do
      context "Assign @chapters" do
        it do
          current_user = User.find_by id: user.id
          expect(current_user.chapters).to eq user.chapters
        end
      end
    end

    describe "User not login" do
      context "Redirect to login" do
        it{expect(response).to redirect_to login_path}
      end
    end
  end
end
