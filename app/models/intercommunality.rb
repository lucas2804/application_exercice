class Intercommunality < ApplicationRecord
  before_save :update_slug
  has_many :communes

  validates :name, presence: true
  validates :siren, presence: true, uniqueness: { :case_sensitive => false }, format: { without: /\s/ }, length: { maximum: 9 }
  validates :form, inclusion: { in: %w(ca cu cc met) }

  # delegate :population, to: :communes

  def communes_hash
    communes.to_hash
  end

  def population
    communes.sum(:population)
  end

  private

  def update_slug
    if slug.nil? && name.present?
      self.slug = name.parameterize
    end
  end
end
