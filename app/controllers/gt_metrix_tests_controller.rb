class GtMetrixTestsController < ApplicationController
  def tests
    tests = Test.all
    render json: tests
  end

  def create_test
    auth = { username: StaticData::API_USERNAME, password: StaticData::API_KEY }
    body = { url: params['url'] }
    response = HTTParty.post(
      "#{StaticData::API_ENDPOINT}/test",
      basic_auth: auth,
      body: body
    )
    json = JSON.parse(response.body)
    if response.code >= 200 && response.code <= 299
      test = Test.new
      test.test_id = json['test_id']
      test.state = 'queued'
      test.url = params['url']
      test.save
      UpdateTaskStatusJob.set(wait: 1.minute).perform_later(test)

      render json: test, status: response.code
    else
      render json: json, status: response.code
    end
  end

  def test
    render json: Test.find(params['id'])
  end
end
