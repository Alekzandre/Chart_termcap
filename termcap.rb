#!/usr/bin/env ruby

#code by Alexandre Carayon @42 in 09/2014

require 'ncurses'
require 'rubygems'
require 'json'
require "net/http"
require "uri"

######################### RECUP DES DONNEES DE QBOLLACH ##################################

uri = URI.parse("http://norminette.42.fr/api.php")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
string = response.body
parsed = JSON.parse(string)
parsed.each {|key, value| puts "#{key} => #{value}\n\r "}

########################## INITIALISATION DES TERMCAPS ###################################

maximum = 0
parsed.each {|key, value| ( maximum = [ maximum, value.to_i ].max ) }

puts 'max : ' + maximum.to_s

#exit

Ncurses.initscr
#Ncurses.curs_set(0)
Ncurses.start_color
Ncurses.init_color(42, 164, 164, 164)
Ncurses.init_pair(1, Ncurses::COLOR_RED, Ncurses::COLOR_BLACK)
Ncurses.init_pair(2, Ncurses::COLOR_WHITE, Ncurses::COLOR_WHITE)
Ncurses.init_pair(3, 42, Ncurses::COLOR_BLACK)

MARGIN_LEFT = 10
MARGIN_BOTTOM = 5

while true
	Ncurses.erase

	for i in 0..(Ncurses.LINES - MARGIN_BOTTOM + 1)
		Ncurses.attrset(Ncurses::COLOR_PAIR(1))
		Ncurses.mvaddstr(i, MARGIN_LEFT - 1, "|")
		Ncurses.attrset(Ncurses::COLOR_PAIR(0))
		Ncurses.mvaddstr(i, 0, (((Ncurses.LINES - MARGIN_BOTTOM + 1) - i) * maximum / (Ncurses.LINES - MARGIN_BOTTOM + 1)).to_s)
	end

	Ncurses.attrset(Ncurses::COLOR_PAIR(3))

	for j in 0..(Ncurses.LINES - MARGIN_BOTTOM + 1)
		for i in MARGIN_LEFT..Ncurses.COLS
			Ncurses.mvaddstr(j * 4, i, "-")
		end
	end

	Ncurses.attrset(Ncurses::COLOR_PAIR(1))

	for i in MARGIN_LEFT..Ncurses.COLS
		Ncurses.mvaddstr(Ncurses.LINES - MARGIN_BOTTOM + 1, i, "-")
	end

	Ncurses.mvaddstr(Ncurses.LINES - MARGIN_BOTTOM + 1, MARGIN_LEFT - 1 , "+")

	Ncurses.attrset(Ncurses::COLOR_PAIR(0))

	x = MARGIN_LEFT
	j = 0
	parsed.each do |key, value|
		size = value.to_i * (Ncurses.LINES - MARGIN_BOTTOM) / maximum
		for i in 0..size
			Ncurses.attrset(Ncurses::COLOR_PAIR(2))
			Ncurses.mvaddstr((Ncurses.LINES - MARGIN_BOTTOM) - i, x, "X")
			Ncurses.attrset(Ncurses::COLOR_PAIR(0))
		end
		if j % 2 == 0
			Ncurses.mvaddstr(Ncurses.LINES - MARGIN_BOTTOM + 2, x - 5, key[5, 11])
		else
			Ncurses.mvaddstr(Ncurses.LINES - MARGIN_BOTTOM + 3, x - 5, key[5, 11])
		end
		x += (Ncurses.COLS - MARGIN_LEFT) / parsed.size
		j += 1
	end

	Ncurses.refresh
	sleep(0.01)
end

Ncurses.endwin