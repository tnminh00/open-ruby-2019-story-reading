require 'rails_helper'

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

    context "Password invalid presence" do
      it{should have_secure_password}
    end
  
    context "Password invalid min lenth" do
      it{should validate_length_of(:password).is_at_least(Settings.password.minimum)}
    end

    context "Before save" do
      it "downcase email" do
        user = FactoryBot.create(:user, email: "TH@gmail.com")
        expect(user.email).to eq "th@gmail.com"
      end
    end

    describe "Instance method" do
      let!(:user){FactoryBot.create :user}

      context "#remember" do
        before{user.remember}

        it "Remember success" do
          expect(user.remember_digest).not_to be_nil
        end
      end

      context "#forget" do
        before do
          user.remember
          user.forget
        end
        
        it "Forget sucess" do
          expect(user.remember_digest).to be_nil
        end
      end

      context "#authenticated?" do
        it "Authenticated true" do
          user.remember
          expect(user.authenticated? user.remember_token).to be true
        end

        it "Authenticated false" do
          expect(user.authenticated? user.remember_token).not_to be true
        end
      end
    end

    describe "Class method" do    
      context ".new_token" do
        it "new token true" do
          expect(described_class.new_token).not_to be_nil
        end
      end

      context ".digest" do
        it "create digest token" do
          expect(described_class.digest(described_class.new_token)).not_to be_nil
        end
      end
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
end
