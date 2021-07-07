require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  context "when third-party API responds with empty array" do
    it "should return an empty array" do
      get root_path

      # stub requests to return

      response_body = JSON.parse(response.body)

      expect(response_body).to eq([])
    end
  end
end
