require './lib/station'
require './lib/line'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

def main_menu
	loop do
		puts "WELCOME TO CHOO CHOO TOWN"
		puts "Press 'a' to add a station"
		puts "Press 'l' to list all stations"
		puts "Press 'i' to add a line"
		puts "Press 't' to see all lines"
		puts "Press 'p' to view all stations on a line"
		puts "Press 'o' to view all lines that go to a station"
		input = gets.chomp 
		case input
		when 'a'
			add_station
		when 'l'
			list_stations
		when 'i'
			add_line
		when 't'
			list_lines
		when 'p'
			list_stations_by_line
		when 'o'
			list_lines_by_station
		when 'e'
			exit
		end
	end
end

def add_line
	puts "What line would you like to add?"
	input = gets.chomp
	new_line = Line.new({:name => input})
	new_line.save
	puts "#{input} line added!"
	main_menu
end

def list_lines
	puts "Here are all the lines:"
	Line.all.each { |line| puts line.name }
	main_menu
end

def add_station
	list_lines
	puts "What line is the station located on?"
	line = Line.find_line(gets.chomp)
	puts "What is the name of the station?"
	input = gets.chomp
	station = Station.new({:name => input})
	station.save
	line.add_station(station.id)
	main_menu
end

def list_stations
	puts "Here are all the stations:"
	Station.all.each { |station| puts station.name}
	main_menu
end

def list_stations_by_line
	list_lines
	puts "Which line would you like to see stations for?"
	line = Line.find_line(gets.chop)
	stations = Station.stop_list(line.id)
	stations.each { |station| puts station.name}
	main_menu
end

main_menu