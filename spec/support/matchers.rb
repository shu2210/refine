# frozen_string_literal: true

RSpec::Matchers.define :be_json_success do
  match do |actual|
    json_response = JSON.parse(actual.body)
    expect(json_response['status']).to eq('success')
  end
end

RSpec::Matchers.define :be_json_error do
  match do |actual|
    json_response = JSON.parse(actual.body)
    expect(json_response['status']).to eq('error')
  end
end
