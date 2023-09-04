class AmazonAdvertisingService
  TOKEN_URL = 'https://api.amazon.com/auth/o2/token'
  GRANT_TYPE = 'refresh_token'

  attr_reader :api_account, :region, :conn

  def initialize(api_account, region, profile = nil)
    @api_account = api_account
    @region = region
    @profile = profile
    @conn = Faraday.new(url: endpoint) do |faraday|
      faraday.request :url_encoded
      faraday.response :follow_redirects
      faraday.adapter Faraday.default_adapter
    end
  end

  def get(path, params = {})
    request(path, :get, params)
  end

  def post(path, params = {})
    request(path, :post, params)
  end

  def get_new_access_token
    body = {
      grant_type: GRANT_TYPE,
      refresh_token: api_account.encrypted_refresh_token,
      client_id: ENV["CLIENT_ID"], 
      client_secret: ENV["CLIENT_SECRET"]
    }
    
    response = Faraday.post(TOKEN_URL, body)
    data = JSON.parse(response.body)

    if data['access_token']
      api_account.update!(
        encrypted_access_token: data['access_token'],
        access_token_expires_at: Time.now + data['expires_in']
      )
    else
      raise "Failed to refresh access token: #{data['error']}"
    end
  end

  private

  def request(path, method, params = {})
    refresh_access_token_if_expired

    response = @conn.send(method) do |req|
      req.url path
      req.headers['Authorization'] = "Bearer #{api_account.encrypted_access_token}"
      req.headers['Amazon-Advertising-API-ClientId'] = ENV["CLIENT_ID"]
      req.headers['Content-Type'] = 'application/json'

      if @profile
        req.headers['Amazon-Advertising-API-Scope'] = @profile.profile_external_id
      end
      
      if method == :get
        req.params = params if params.any?
      elsif method == :post
        req.body = params.to_json
      end

    end
    
    
    if response.success?
      JSON.parse(response.body)
    else
      raise RuntimeError, "API request failed: #{response.body}"
    end
  end

  def endpoint
    case region.code
    when "NA"
      "https://advertising-api.amazon.com"
    when "EU"
      "https://advertising-api-eu.amazon.com"
    when "FE"
      "https://advertising-api-fe.amazon.com"
    else
      raise "Invalid region code: #{region.code}"
    end
  end

  def refresh_access_token_if_expired
    get_new_access_token if api_account.access_token_expires_at.nil? || api_account.access_token_expires_at < Time.now
  end
end
