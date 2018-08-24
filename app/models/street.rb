class Street < ApplicationRecord
  has_many :communes_streets
  has_many :communes, through: :communes_streets

  validates :title, presence: true
  validates :from, numericality: true, allow_nil: true
  validates :to, numericality: true, allow_nil: true
  validate :to_must_greater_than_from

  private

  def to_must_greater_than_from
    return true if to.blank? || from.blank?
    errors.add(:to, "must be greater than from") if to <= from
  end
end
