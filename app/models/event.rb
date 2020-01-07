class Event < ApplicationRecord
  include ActiveModel::Validations

  validates :name, :location, :start_time, :end_time, :sign_in_id, presence: true
  validates :sign_in_id, uniqueness: true
  validate :end_after_start_time

  def end_after_start_time
    return if end_time.blank? || start_time.blank?
    if end_time < start_time
      errors.add(:end_time, "can't be before the start time")
    end
  end

  def self.gen_sign_in_id
    SecureRandom.hex(8)
  end

end
