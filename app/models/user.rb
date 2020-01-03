class User < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :name, :email

  def self.create_with_omniauth!(auth_hash)
    create! do |user|
      user.name = auth_hash['info']['name']
      user.email = auth_hash['info']['email']
    end
  end
end