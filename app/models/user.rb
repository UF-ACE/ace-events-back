class User < ApplicationRecord
  include ActiveModel::Validations

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true

  def chair?
    role > 0
  end

  def eboard?
    role > 1
  end

  def self.build_with_omniauth!(auth_hash)
    # Check for existing user
    potential_user = find_by(email: auth_hash['info']['email'])
    return potential_user unless potential_user.nil?

    role = User.get_role_by_oidc_groups(auth_hash['extra']['raw_info']['groups'])

    # Doesn't exist, create
    params = ActionController::Parameters.new(name: auth_hash['info']['name'], email: auth_hash['info']['email'], role: role).permit(:name, :email, :role)
    user = User.new(params)
    if user.save
      return user
    else
      raise
    end
  end

  def self.get_role_by_oidc_groups(groups)
    groups.map { |group|
      case group
      when "ace-member"
        0
      when "ace-chair"
        1
      when "ace-eboard"
        2
      else
        -1
      end
    }.max
  end
end