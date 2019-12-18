require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  describe "GET #index" do
    before{get :index}
    let!(:stories){FactoryBot.create_list :story, 5}

    context "Assign @stories" do
      it{expect(assigns(:stories)).to eq stories}
    end

    context "Render index template" do
      it{expect(response).to render_template :index}
    end
  end

  describe "GET #show" do
    let!(:story){FactoryBot.create :story_with_category}
    before{get :show, params:{id: story.id}}
    
    context "Assign @story" do
      it{expect(assigns(:story)).to eq story}
    end

    context "Render show template" do
      it{expect(response).to render_template :show}
    end

    context "Assign @chapters" do
      let!(:chapters){FactoryBot.create_list :chapter, 5, story: story}

      it{expect(assigns(:story).chapters).to eq chapters}
    end

    context "Assign @categories" do
      it{expect(assigns(:story).categories).to eq story.categories}
    end
  end

  describe "PUT #update" do
    let!(:admin){FactoryBot.create :user, is_admin: true}
    let!(:story){FactoryBot.create :story_with_category}

    describe "Valid attributes" do
      before do
        session[:user_id] = admin.id
        put :update, params:{id: story.id, category: {ids:["","Cat 1","Cat 2"]},
          story: FactoryBot.attributes_for(:story_with_category, name: "Story Story")}
      end

      context "Change story attribute" do
        it{expect(story.reload.name).to eq "Story Story"}
      end

      context "Redirect to story detail" do
        it{expect(response).to redirect_to assigns(:story)}
      end
    end

    describe "Invalid attributes" do
      before do
        session[:user_id] = admin.id
        put :update, params:{id: story.id, category: {ids:["","Cat 1","Cat 2"]},
          story: FactoryBot.attributes_for(:story_with_category, name: nil)}
      end

      context "Does not save story" do
        it{expect{put :update, params:{id: story.id, category: {ids:["","Cat 1","Cat 2"]},
          story: FactoryBot.attributes_for(:story_with_category, name: nil)}}.to_not change(Story,:count)}
      end

      context "Does not change story attributes" do
        it{expect(story.reload).not_to be_nil}
      end

      context "Render template edit" do
        it{expect(response).to render_template :edit}
      end
    end 
  end
end
