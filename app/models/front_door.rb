require 'net/http'

class FrontDoor
  def self.open_door_and_elevator
    uri = URI.parse("http://#{ENV['QIPADDRESS']}:#{ENV['QPORT']}/stateFull.xml?relay1state=1&relay2state=1")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(ENV['QUSER'], ENV['QPWORD'])
    response = http.request(request)
    xml_doc  = Nokogiri::XML(response.body)
    puts "*****************"
    puts "*****************"
    p xml_doc
    puts "*****************"
    puts "*****************"
    xml_doc.xpath("//relay1state").text == "1" && xml_doc.xpath("//relay2state").text == "1"
  end

  def self.close_door
    uri = URI.parse("http://#{ENV['QIPADDRESS']}:#{ENV['QPORT']}/stateFull.xml?relay1state=0")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(ENV['QUSER'], ENV['QPWORD'])
    response = http.request(request)
    xml_doc  = Nokogiri::XML(response.body)
    xml_doc.xpath("//relay1state").text == "0"
  end

  def self.close_elevator
    uri = URI.parse("http://#{ENV['QIPADDRESS']}:#{ENV['QPORT']}/stateFull.xml?relay2state=0")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(ENV['QUSER'], ENV['QPWORD'])
    response = http.request(request)
    xml_doc  = Nokogiri::XML(response.body)
    xml_doc.xpath("//relay2state").text == "0"
  end
end