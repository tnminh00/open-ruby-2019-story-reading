require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe "Validations" do
    subject do
      story = FactoryBot.create :story
      FactoryBot.create :chapter, story: story
    end

    context "Valid attribute" do
      it{is_expected.to be_valid}
    end

    context "Name invalid presence" do
      it{should validate_presence_of(:name)}
    end

    context "Content invalid presence" do
      it{should validate_presence_of(:content)}
    end

    context "Chapter number invalid presence" do
      it{should validate_presence_of(:chapter_number)}
    end

    context "Chapter number invalid numericality" do
      it{should validate_numericality_of(:chapter_number).is_greater_than 0}
    end
  end

  describe "Scope" do
    story = FactoryBot.create :story
    let!(:chapter1){FactoryBot.create(:chapter, story: story, chapter_number: 1)}
    let!(:chapter2){FactoryBot.create(:chapter, story: story, chapter_number: 2)}
    let!(:chapter3){FactoryBot.create(:chapter, story: story, chapter_number: 3)}

    context "#order_chapter" do
      it{expect(Chapter.all.order_chapter).to eq [chapter3, chapter2, chapter1]}
    end
  end

  describe "Delegate" do
    it{should delegate_method(:name).to(:story).with_prefix(true)}
  end

  describe "Associations" do
    context "Belongs to story" do
      it{should belong_to(:story)}
    end

    context "Has many histories" do
      it{should have_many(:histories).dependent(:destroy)}
    end

    context "Has many users" do
      it{should have_many(:users).through(:histories)}
    end
  end

  describe "Instance method" do
    story = FactoryBot.create :story
    let!(:chapter1){FactoryBot.create(:chapter, story: story, chapter_number: 1)}
    let!(:chapter2){FactoryBot.create(:chapter, story: story, chapter_number: 2)}
    let!(:chapter3){FactoryBot.create(:chapter, story: story, chapter_number: 3)}
    let!(:chapter4){FactoryBot.create(:chapter, story: story, updated_at: "2019-12-11 09:36:45")}

    context "#next_chapter" do
      it "Next chapter" do
        expect(chapter2.next_chapter).to eq chapter3
      end
    end

    context "#previous_chapter" do
      it "Previous chapter" do
        expect(chapter3.previous_chapter).to eq chapter2
      end
    end

    context "#date_time" do
      it "Date time" do
        expect(chapter4.date_time).to eq "11/12/2019"
      end
    end
  end
end
