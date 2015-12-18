json.array!(@fips_tzs) do |fips_tz|
  json.extract! fips_tz, :id, :tz_n, :url_string_fips, :doc
  json.url fips_tz_url(fips_tz, format: :json)
end
