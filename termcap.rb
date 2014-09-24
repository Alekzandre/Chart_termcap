#!/usr/bin/env ruby

require 'ncurses.rb'
require 'rubygems'
require 'json'
require "net/http"
require "uri"
require 'ffi-ncurses'
require 'ffi-ncurses/ord_shim'  # for 1.8.6 compatibility , pas sur que ca soit utile
include FFI::NCurses


############################## MIS EN PLACE DES COULEURS ###############################


init_pair(1, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::BLACK)
init_pair(2, FFI::NCurses::Color::RED, FFI::NCurses::Color::BLACK)
init_pair(3, FFI::NCurses::Color::GREEN, FFI::NCurses::Color::BLACK)
init_pair(4, FFI::NCurses::Color::YELLOW, FFI::NCurses::Color::BLACK)
init_pair(5, FFI::NCurses::Color::BLUE, FFI::NCurses::Color::BLACK)
init_pair(6, FFI::NCurses::Color::MAGENTA, FFI::NCurses::Color::BLACK)
init_pair(7, FFI::NCurses::Color::CYAN, FFI::NCurses::Color::BLACK)
init_pair(8, FFI::NCurses::Color::WHITE, FFI::NCurses::Color::BLACK)

init_pair(9, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::BLACK)
init_pair(10, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::RED)
init_pair(11, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::GREEN)
init_pair(12, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::YELLOW)
init_pair(13, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::BLUE)
init_pair(14, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::MAGENTA)
init_pair(15, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::CYAN)
init_pair(16, FFI::NCurses::Color::BLACK, FFI::NCurses::Color::WHITE)


######################### RECUP DES DONNEES DE QBOLLACH ##################################

uri = URI.parse("http://norminette.42.fr/api.php")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
string = response.body
parsed = JSON.parse(string)
parsed.each {|key, value| puts "#{key} => #{value}"}

########################## INITIALISATION DES TERMCAPS ###################################

initscr
clear
printw("Welcome to Alex's Graph powered by YOUR MOM")
refresh
getch
endwin

initscr
start_color
curs_set 0
raw
cbreak
noecho
clear
move 1, 1
standout
printw("Ferme bien ta gueule")
backgr
standend
refresh
ch = getch
endwin

