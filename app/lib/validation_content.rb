require 'net/http'
require 'json'
class ValidationContent
  attr_accessor :content

  @base_uri =  'https://debatememoderator.cognitiveservices.azure.com/contentmoderator/moderate/v1.0/ProcessText/Screen?autocorrect=true&classify=True&language=fra'
  @headers = {'Content-Type' => 'text/plain',
              'Ocp-Apim-Subscription-Key' => '15143594e225468d87284d82119c43b1'}

  def initialize(content)
    @content = content
  end

  def get_response
    uri = URI('https://debatememoderator.cognitiveservices.azure.com/contentmoderator/moderate/v1.0/ProcessText/Screen')
    uri.query = URI.encode_www_form({
                                        :autocorrect => 'True',
                                        :PII => 'True',
                                        :language => 'fra'
                                    })

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'text/plain'
    request['Ocp-Apim-Subscription-Key'] = '15143594e225468d87284d82119c43b1'
    request.body = @content
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(request) }
    response.body
  end

  def get_corrected_text
    response = JSON.parse(get_response)
    if !response['Terms'].nil? and response['Terms'].count > 0
      return response['Terms']
    end
    response['AutoCorrectedText']
  end

end
