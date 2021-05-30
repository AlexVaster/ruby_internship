require 'socket'
require_relative 'calculator'

class Server
  attr_reader :server, :prices
  def initialize(port)
    @server = TCPServer.open(port)
    @prices = read_price
  end

  def read_price(path = 'prices.csv')
    CSV.foreach(path) do |row|
      @prices[row[0]] = row[1]
    end
  end

  def run
    while session = server.accept
      url = session.gets
      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: text/html\r\n"
      session.print "\r\n" 
      if !url.include?("/favicon.ico")
        calculator = Calculator.new(url, prices)
        session.print calculator.result
      end
      session.close  
    end
  end
end