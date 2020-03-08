class GtMetrixAccountsController < ApplicationController
  def account_info
    auth = { username: StaticData::API_USERNAME, password: StaticData::API_KEY }
    response = HTTParty.get("#{StaticData::API_ENDPOINT}/status", basic_auth: auth)
    render json: response.body
  end
end
