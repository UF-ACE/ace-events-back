class Attendee < ApplicationRecord
  include ActiveModel::Validations
  
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true
  validates_uniqueness_of :user, :scope => [:event]

  def to_builder
    Jbuilder.new do |attendee|
      attendee.id user.id
      attendee.name user.name
    end
  end
end
