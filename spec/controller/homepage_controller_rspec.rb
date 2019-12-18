require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  describe "GET #home" do
    before{get :home}

    context "Return to success response" do
      it{expect(response.status).to eq 200}
    end

    context "Return home template" do
      it{expect(response).to render_template :home}
    end
  end
end
