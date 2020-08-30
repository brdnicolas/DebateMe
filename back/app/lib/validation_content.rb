require 'net/http'
require 'json'

class ValidationContent
  attr_accessor :content

  def get_response
    # Build the request and exec it. There is some issues: if the creditentials are wrong or absent. Just return the
    # initial text in that case
    request = build_request
    raise KeyError if request.nil?

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }
    raise KeyError if %w[401 404].include? response.code

    response.body
  rescue
    { Terms: nil, AutoCorrectedText: @content }.to_json
  end

  def build_request
    # Build a request that contains all params and creditentials
    uri = URI(ENV.fetch('AZURE_ENDPOINT'))
    uri.query = URI.encode_www_form({ autocorrect: 'True', PII: 'True', language: 'fra' })
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'text/plain'
    request['Ocp-Apim-Subscription-Key'] = ENV.fetch('AZURE_KEY')
    request.body = @content
    request
  rescue KeyError
    nil
  end

  def self.get_corrected_text(content)
    # return a list of forbidden terms or the corrected text, if there some forbidden terms detected
    @content = content
    response = JSON.parse(get_response)
    !response['Terms'].nil? && response['Terms'].count.positive? ? response['Terms'] : response['AutoCorrectedText']
  end

end
