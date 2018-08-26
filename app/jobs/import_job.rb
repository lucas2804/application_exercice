class ImportJob < ApplicationJob
  queue_as :default

  def perform(csv_filename)
    DataImport.create(filename: csv_filename)
  end
end
