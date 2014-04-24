require 'lita'
require 'nokogiri'

module Lita
  module Handlers
    class Lulz < Handler
      route(/:lulz/i, :lulz, command: false, help: { "lulz" => "Display a single image" })
      route(/:lulzbomb/i, :lulzbomb, command: false, help: { "lulzbomb" => "Display 6 images" })

      BASE_URL = "http://bukk.it"

      def lulz(response)
        doc = Nokogiri::HTML(open(BASE_URL))
        images = doc.xpath("//a").to_a[5..-1]

        response.reply BASE_URL + "/" + images.sample
      end

      def lulzbomb(response)
        doc = Nokogiri::HTML(open(BASE_URL))
        images = doc.xpath("//a").to_a.shuffle[0..5]

        images.each do |image|
          response.reply BASE_URL + "/" + image
        end
      end
    end
    Lita.register_handler(Lulz)
  end
end
