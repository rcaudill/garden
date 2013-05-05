require "rubygems"
require "serialport"
require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "/home/rcaudill/garden/rails/garden/db/development.sqlite3",
    :timeout => 5000
)

class Reading < ActiveRecord::Base
end

#params for serial port
port_str = "/dev/ttyUSB0"  #may be different for you
baud_rate = 57600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

#just read forever
while true do
  #sp.write 10000
  i=""
  while i=="" do i=sp.gets.chomp end
  puts i
  Reading.create(:reading => i, :time_stamp => Time.now)
  puts Time.now
  #puts "sleep"
  sleep 30 
  puts "flush"
  sp.flush
  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  #puts "awake"
end

sp.close   
