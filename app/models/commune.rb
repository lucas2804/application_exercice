class Commune < ApplicationRecord
  belongs_to :intercommunality
  has_many :communes_streets
  has_many :streets, through: :communes_streets
  validates :name, presence: true
  validates :code_insee, presence: true, length: { minimum: 4 }
end
