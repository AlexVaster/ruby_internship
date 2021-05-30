require 'socket'

require_relative 'calculate_vm'

class Server
  attr_reader :server
  def initialize(port)
    @server = TCPServer.open(port)
  end

  def run
    while session = server.accept
      url = session.gets
      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: text/html\r\n"
      session.print "\r\n" 
      if !url.include?("/favicon.ico")
        calculator = Calculator.new(url)
        calculator.read_price
        session.print calculator.result
      end
      session.close  
    end
  end
end