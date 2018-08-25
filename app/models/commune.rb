class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: true
  has_many :communes_streets
  has_many :streets, through: :communes_streets

  validates :name, presence: true
  validates :code_insee, presence: true, length: { minimum: 4 }

  scope :to_hash, -> { order(code_insee: :asc).pluck(:code_insee, :name).to_h }

  def self.search(term)
    where("name LIKE ?", "%#{sanitize_sql_like(term)}%")
  end
end
