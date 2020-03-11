class UpdateTaskStatusJob < ApplicationJob
  queue_as :default

  def perform(test)
    auth = { username: StaticData::API_USERNAME, password: StaticData::API_KEY }
    response = HTTParty.get(
      "#{StaticData::API_ENDPOINT}/test/#{test.test_id}",
      basic_auth: auth
    )
    json = JSON.parse(response.body)

    if response.code >= 200 &&
       response.code <= 299
      test.state = json['state']
      test.error = json['error']
      test.results = json['results']
      test.save
    end

    if json['state'] == 'completed' || json['state'] == 'error'
      # nothing to do
    else
      UpdateTaskStatusJob.set(wait: 1.minute).perform_later(test)
    end
  end
end
