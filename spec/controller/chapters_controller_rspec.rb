require 'rails_helper'

RSpec.describe ChaptersController, type: :controller do
  let!(:admin){FactoryBot.create :user, is_admin: true}
  let!(:story){FactoryBot.create :story}
  let!(:chapter){FactoryBot.create :chapter, story: story}

  describe "GET #show" do
    let!(:user){FactoryBot.create :user}
    let!(:history){FactoryBot.create :history, chapter: chapter, user: user}
    before{get :show, params:{id: chapter.id}}

    context "Assign @chapter" do
      it{expect(assigns(:chapter)).to eq chapter}
    end

    context "Update total view" do
      it{expect(Story.increment_counter :total_view, story.id).to eq 1}
    end

    context "Update history" do
      it{expect(history.chapter_id).to eq chapter.id}
    end
  end

  describe "POST #create" do
    let!(:chapter1){FactoryBot.create :chapter, story: story, chapter_number: 1}
    before{session[:user_id] = admin.id}

    describe "Valid attributes" do
      before do
        post :create, params:{chapter: FactoryBot.attributes_for(:chapter, story: story, chapter_number: 2),
          story:{id: story.id}}
      end

      context "Create chapter success" do
        it{expect{post :create, params:{chapter: FactoryBot.attributes_for(:chapter, story: story),
          story:{id: story.id}}}.to change(Chapter,:count).by(1)}
      end

      context "Redirect to story path" do
        it{expect(response).to redirect_to story_path(assigns(:chapter).story)}
      end
    end

    describe "Invalid attributes" do
      before do
        post :create, params:{chapter: FactoryBot.attributes_for(:chapter, story: story, name: nil),
          story:{id: story.id}}
      end

      context "Render template new chapter" do
        it{expect(response).to render_template :new}
      end
    end

    describe "Chapter existed" do
      before do
        post :create, params:{chapter: FactoryBot.attributes_for(:chapter, story: story, chapter_number: 1),
          story:{id: story.id}}
      end

      it{expect(response).to redirect_to story_path(assigns(:story))}
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:user_id] = admin.id
      @chapter = FactoryBot.create :chapter, story: story
    end

    context "Delete chapter" do
      it{expect{delete :destroy, params:{id: @chapter}}.to change(Chapter,:count).by(-1)}
    end

    context "Redirect to story path" do
      before{delete :destroy, params:{id: @chapter}}
      it{expect(response).to redirect_to story_path(assigns(:chapter).story)}
    end
  end
end
