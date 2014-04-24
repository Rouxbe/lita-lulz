require 'lita'
require 'nokogiri'

module Lita
  module Handlers
    class Lulz < Handler
      route(/\blulz\b/i, :lulz, command: true, help: { "lulz" => "Display a single image" })
      route(/\blulz bomb( (\d+))?/i, :bomb, command: true, help: { "lulz bomb" => "Display five images", "lulz bomb N" => "Display N lulz" })

      BASE_URL = "http://bukk.it"

      def lulz(response)
        doc = Nokogiri::HTML(open(url))
        images = doc.xpath("//a").to_a[5..-1]

        response.reply url + "/" + images.sample
      end

      def bomb(response)
        doc = Nokogiri::HTML(open(url))
        images = doc.xpath("//a").to_a[5..-1]

        images.each do |image|
          response.reply url + "/" + image
        end
      end
    end
    Lita.register_handler(Lulzbomb)
  end
end
