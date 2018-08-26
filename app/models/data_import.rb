require 'csv'
class DataImport < ApplicationRecord

  HEADER = { intercommunality_id:   'dep_epci', intercommunality_siren: 'siren_epci',
             intercommunality_name: 'nom_complet', intercommunality_form: 'form_epci', fisc_epci: 'fisc_epci', dep_com: 'dep_com',
             code_insee:            'insee', siren_com: 'siren_com', commune_name: 'nom_com', population: 'pop_total' }

  before_save :update_processed_at
  before_create :import_csv_data
  after_create :update_imported__at


  def import_csv_data
    intercommunalities = []
    commues            = []

    File.open(filename, 'r:ISO-8859-1') do |file|
      CSV.parse(file.read.encode("UTF-8"), col_sep: ";", headers: true) do |row|
        intercommunalities << build_intercommunality(row)
        commues << build_commune(row)
      end
    end

    intercommunalities.uniq! { |i| i.siren }
    Intercommunality.import(intercommunalities)
    Commune.import(commues)
  end

  private

  def build_intercommunality(row)
    Intercommunality.new(
      id:    row[HEADER[:intercommunality_id]],
      siren: row[HEADER[:intercommunality_siren]],
      name:  row[HEADER[:intercommunality_name]],
      form:  row[HEADER[:intercommunality_form]].slice(0, 3).downcase
    )
  end

  def build_commune(row)
    Commune.new(
      code_insee:          row[HEADER[:code_insee]],
      name:                row[HEADER[:commune_name]],
      population:          row[HEADER[:population]],
      intercommunality_id: row[HEADER[:intercommunality_id]]
    )
  end

  def update_processed_at
    self.processed_at = Time.zone.now
  end

  def update_imported__at
    self.imported_at = Time.zone.now
  end
end

