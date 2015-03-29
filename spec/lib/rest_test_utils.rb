module RestTestUtils
  private

  def http_get(an_url = '')
    get build_url(an_url)
  end

  def http_delete(an_id)
    delete "#{build_url}/#{an_id}"
  end

  def http_post(a_body)
    post build_url, a_body.to_json, JSON_HEADERS
  end

  def response_boby
    JSON.parse(response.body).collect {|an_item| OpenStruct.new an_item}
  end

  def build_url(an_url = '')
    "#{BASE_URL}#{url.to_s}#{an_url}"
  end

  def expect_201_http
    expect(response.status).to eq 201
  end

  def expect_200_http
    expect(response.status).to eq 200
  end

  # -------------------------------------------------------------------------
  # Constants
  # -------------------------------------------------------------------------

  JSON_HEADERS = {
    "Accept"        => "application/json",
    "Content-Type"  => "application/json"
  }

  BASE_URL = 'api/'
end
