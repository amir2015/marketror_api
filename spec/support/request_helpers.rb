#rubocop:disable all
module RequestHelpers
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  def api_authorization_header(token)
    request.headers["Authorization"] = token
  end
end
