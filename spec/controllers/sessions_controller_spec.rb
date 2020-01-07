require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST create" do
    let (:headers) { 
      user = build(:user)
      { 'omniauth.auth' => OmniAuth::AuthHash.new(
        {
          :info => {
            name: user.name,
            email: user.email
          },
          :extra => {
            :raw_info => {
              groups: ["ace-chair", "ace-eboard", "ace-member", "kubernetes-admin", "kubernetes-user"]
            }
          }
        })
      } 
    }

    it "creates a new user if it does not exist" do
      request.env.merge!(headers)
      expect{ post :create }.to change(User, :count).by(1)
    end
  end
end
