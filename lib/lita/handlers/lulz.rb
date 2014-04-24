require 'lita'
require 'nokogiri'

module Lita
  module Handlers
    class Lulz < Handler
      route(/\blulz\b/i, :lulz, command: true, help: { "lulz" => "Display a single image" })
      route(/\blulz bomb( (\d+))?/i, :bomb, command: true, help: { "lulz bomb" => "Display five images" })

      BASE_URL = "http://bukk.it"

      def lulz(response)
        doc = Nokogiri::HTML(open(BASE_URL))
        images = doc.xpath("//a").to_a[5..-1]

        response.reply BASE_URL + "/" + images.sample
      end

      def bomb(response)
        doc = Nokogiri::HTML(open(BASE_URL))
        images = doc.xpath("//a").to_a[5..-1]

        images.each do |image|
          response.reply BASE_URL + "/" + image
        end
      end
    end
    Lita.register_handler(Lulz)
  end
end
