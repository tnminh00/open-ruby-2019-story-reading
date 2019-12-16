require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "Validations" do
    subject{FactoryBot.create :story}

    context "Valid attribute" do
      it{is_expected.to be_valid}
    end

    context "Name invalid presence" do
      it{should validate_presence_of(:name)}
    end

    context "Name invalid max length" do
      it{should validate_length_of(:name).is_at_most(Settings.story.name_maximum)}
    end

    context "Author invalid presence" do
      it{should validate_presence_of(:name)}
    end

    context "Author invalid max length" do
      it{should validate_length_of(:author).is_at_most(Settings.story.author_maximum)}
    end

    context "Introduction invalid presence" do
      it{should validate_presence_of(:introduction)}
    end

    context "Introduction invalid max length" do
      it{should validate_length_of(:introduction).is_at_most(Settings.story.introduction_maximum)}
    end
  end

  describe "Scope" do
    let!(:story1){FactoryBot.create(:story, name: "Boat")}
    let!(:story2){FactoryBot.create(:story, name: "Ship")}
    let!(:story3){FactoryBot.create(:story, name: "Kayak")}

    context "#search_by_name" do
      it{expect(Story.search_by_name("bo")).to eq [story1]}
    end
  end

  describe "Associations" do
    context "Has many chapters" do
      it{should have_many(:chapters).dependent(:destroy)}
    end

    context "Has many category_stories" do
      it{should have_many(:category_stories)}
    end

    context "Has many categories" do
      it{should have_many(:categories).through(:category_stories)}
    end
  end
end
