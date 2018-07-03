require 'nokogiri'
require 'rest-client'

module Parse
    class Animal
        def self.cat
            @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
            @cat_xml = RestClient.get(@url)
            @cat_doc = Nokogiri::XML(@cat_xml)
            @cat_url = @cat_doc.xpath('//url').text
        end
    end
end
