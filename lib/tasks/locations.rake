require "httparty"

namespace :locations do
  desc "Pulls initial list of locations from openweathermap.org"
  task fetch: :environment do
    locatons_doc_url = "https://openweathermap.org/storage/app/media/cities_list.xlsx"

    tmpfile_path = Rails.root.join("./tmp/locations.xlsx").to_s
    File.open(tmpfile_path, "wb") do |file|
      file.binmode
      data = HTTParty.get(locatons_doc_url).body
      file.write(data)
    end

    locations = Roo::Excelx.new(tmpfile_path)
    locations.each_row_streaming(offset: 1) do |row|
      name = row[0].value
      country = row[3].value
      Locations::FindOrCreate.new(name:, country:).call!
    end
  ensure
    File.delete(tmpfile_path) if File.exist?(tmpfile_path)
  end
end
