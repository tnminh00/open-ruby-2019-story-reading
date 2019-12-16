require 'rails_helper'

RSpec.describe CategoryStory, type: :model do
  describe "Associations" do
    context "Belongs to story" do
      it{should belong_to(:story)}
    end

    context "Belongs to category" do
      it{should belong_to(:category)}
    end
  end
end
