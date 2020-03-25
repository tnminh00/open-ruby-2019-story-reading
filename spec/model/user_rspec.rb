require 'rails_helper'

RSpec.shared_examples "password format invalid" do |pass|
  it "contain not enough 3 of the following 4: a lowercase letter, an uppercase letter, a digit, a symbol" do
    FactoryBot.build(:user, password: pass,
      password_confirmation: pass).should_not be_valid
  end
end

RSpec.shared_examples "password format valid" do |pass|
  it "contain 3 of the following 4: a lowercase letter, an uppercase letter, a digit, a symbol" do
    FactoryBot.build(:user, password: pass,
      password_confirmation: pass).should be_valid
  end
end

RSpec.shared_examples "password different" do
  it "must be different email or name" do
    expect(user).not_to be_valid
  end
end

RSpec.describe User, type: :model do
  describe "Validations" do
    subject{FactoryBot.create :user}

    context "Valid attribute" do
      it{is_expected.to be_valid}
    end

    context "Name invalid presence" do
      it{should validate_presence_of(:name)}
    end

    context "Name invalid max length" do
      it{should validate_length_of(:name).is_at_most(Settings.name.maximum)}
    end

    context "Email invalid presence" do
      it{should validate_presence_of(:email)}
    end

    context "Email invalid max length" do
      it{should validate_length_of(:email).is_at_most(Settings.email.maximum)}
    end

    context "Email invalid format" do
      it{should allow_value("tnminh@gmail.com").for(:email)}
    end

    context "Email invalid uniqueness" do
      it{should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    end
  
    context "Password invalid min lenth" do
      it{should validate_length_of(:password).is_at_least(Settings.password.minimum)}
    end

    describe "Associations" do
      context "Has many histories" do
        it{should have_many(:histories)}
      end

      context "Has many chapters" do
        it{should have_many(:chapters).through(:histories)}
      end
    end
  end

  describe "Password Validations" do
    context "Password" do
      include_examples "password different" do
        let!(:user){FactoryBot.build :user, password: "Abc123",
          password_confirmation: "Abc123", name: "Abc123"}
      end

      include_examples "password different" do
        let!(:user){FactoryBot.build :user, password: "user1@gmail.com",
          password_confirmation: "user1@gmail.com", email: "user1@gmail.com"}
      end
    end

    context "Password format" do
      password_format_invalid = ["aaaaaaa", "aaaAAAA", "aa11111", "AA11111",
        "@@@@AAA", "AAAAAAA", "1111111", "@@@@@@@", "aaa@@@@", "@@@1111"]
      password_format_valid = ["Abc123", "ABC@123", "abc@123",
        "Abc@123", "Abc@@@"]

      password_format_invalid.each do |pass|
        include_examples "password format invalid", pass
      end

      password_format_valid.each do |pass|
        include_examples "password format valid", pass
      end
    end
  end
end
