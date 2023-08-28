
require 'socket'

Thread.new do
  server = TCPServer.new(12345)

  client = server.accept

  begin
    data = client.gets.chomp
    puts "Received: #{data}"
  ensure
    client.close
  end
end

system("./audio.engine/t")

###Network.rb
