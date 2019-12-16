require 'rails_helper'

RSpec.describe History, type: :model do
  describe "Associations" do
    context "Belongs to user" do
      it{should belong_to(:user)}
    end

    context "Belongs to chapter" do
      it{should belong_to(:chapter)}
    end
  end
end
