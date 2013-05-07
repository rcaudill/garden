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

while true do
  start = Time.now
  puts "Start: #{start}"
  a = Array.new
  while i=sp.gets do
    puts i
    if !i.nil? then
      if i!="" and (1..1024).member?(i.to_i) then
        a.push(i.to_i)
      end
      if Time.now - start > 30 then
        break
      end
    end
  end
  if a.length > 20 then
    puts "Before: #{a.length}"
    a = a.sort[5..-6]
    puts "After: #{a.length}"
    average = (a.inject{|sum,x| sum + x }/a.length).to_i
    puts "Average: #{average}"

    Reading.create(:reading => average, :time_stamp => Time.now)

    if average < 900 then
      puts "watering"
      sp.write "15000"
    else 
      puts "no watering required"
    end
  end


  #
  #sleep 10 
end

