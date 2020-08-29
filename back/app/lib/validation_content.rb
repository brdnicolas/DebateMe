require 'net/http'
require 'json'

class ValidationContent
  attr_accessor :content

  def initialize(content)
    @content = content
  end

  def get_response
    uri = URI(ENV.fetch('AZURE_ENDPOINT'))
    uri.query = URI.encode_www_form({ autocorrect: 'True', PII: 'True', language: 'fra' })
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'text/plain'
    request['Ocp-Apim-Subscription-Key'] = ENV.fetch('AZURE_KEY')
    request.body = @content
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }
    raise KeyError if %w[401 404].include? response.code

    response.body
  rescue
    { Terms: nil, AutoCorrectedText: @content }.to_json
  end

  def get_corrected_text
    response = JSON.parse(get_response)
    return response['Terms'] if !response['Terms'].nil? && response['Terms'].count.positive?

    response['AutoCorrectedText']
  end

end
