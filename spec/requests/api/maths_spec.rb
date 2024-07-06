require 'rails_helper'

RSpec.describe "Api::Maths", type: :request do
  describe "POST /api/max_sum" do
    it "returns the correct maximum sum subarray" do
      post "/api/max_sum", params: { "numbers": [1,-3,2,1,-1] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [2, 1] })
    end

    it "returns the entire array if it's the maximum sum" do
      post "/api/max_sum", params: { "numbers": [1, 2, 3] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [1, 2, 3] })
    end

    it "returns a single number if it's the maximum sum" do
      post "/api/max_sum", params: { "numbers": [-2, 5, -1] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [5] })
    end

    it "returns the first occurrence of maximum sum if there are multiple" do
      post "/api/max_sum", params: { "numbers": [1, 2, 3, -10, 1, 2, 3] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [1, 2, 3] })
    end

    it "handles negative numbers correctly" do
      post "/api/max_sum", params: { "numbers": [-2, -1, -3] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [-1] })
    end

    it "returns the single number when only one number is provided" do
      post "/api/max_sum", params: { "numbers": [42] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => [42] })
    end

    it "returns 'Not Enough Numbers' when no numbers are provided" do
      post "/api/max_sum", params: { numbers: [] }.to_json, headers: { "CONTENT_TYPE" => "application/json" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "max_sum" => "Not Enough Numbers" })
    end
  end
end
