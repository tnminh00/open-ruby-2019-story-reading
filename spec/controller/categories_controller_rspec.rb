require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    let!(:categories){FactoryBot.create_list :category, 3}
    before{get :index}

    context "Assign @categories" do
      it{expect(assigns(:categories)).to eq categories}
    end
  end

  describe "GET #show" do
    let!(:category){FactoryBot.create :category_with_story}
    before{get :show, params:{id: category.id}}

    context "Assign @category" do
      it{expect(assigns(:category)).to eq category}
    end

    context "Assign @stories" do
      it{expect(assigns(:category).stories).to eq category.stories}
    end
  end
end
