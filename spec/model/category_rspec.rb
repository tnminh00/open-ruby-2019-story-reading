require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Associations" do
    context "Has many category_stories" do
      it{should have_many(:category_stories)}
    end

    context "Has many stories" do
      it{should have_many(:stories).through(:category_stories)}
    end
  end
end
