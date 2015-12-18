json.array!(@proxies) do |proxy|
  json.extract! proxy, :id, :proxy_address, :proxy_port, :proxy_status, :proxy_timeout
  json.url proxy_url(proxy, format: :json)
end
