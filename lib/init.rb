require "rubygems"
require "json"

require_relative "connection.rb"

#Variables
listName = ""
listId = ""
path = ""

#Set Token and Client Id
begin
	setToken(ENV["WUNDERLIST_OAUTH_TOKEN"])
	setClientID(ENV["WUNDERLIST_CLIENTID"])
rescue Exception => e 
	puts "[!] Error trying to catch environmental variables => " + e.to_s
	exit
end	
	
#Create List
puts "[?] Insert List Name"
STDOUT.flush  
listName = gets.chomp  

begin
	puts '[+] Creating List ' + listName.to_s
	resp = post("http://a.wunderlist.com/api/v1/lists",{
				"title" => listName.to_s
			},"")
	listId = (JSON.parse(resp))["id"]
rescue Exception => e 
	puts "[!] Error creating the list => " + e.to_s
	exit
end	


puts "[?] Insert path of the file (with .txt) Ex: ./../hello.txt"
STDOUT.flush  
path = gets.chomp  

puts "[+] Leyendo Archivo"
puts "[+] Colocando Tareas"

begin
	counter = 1
	File.open(path.to_s, "r") do |f|
	  f.each_line do |line|
		  	post("http://a.wunderlist.com/api/v1/tasks",
		  		{
				  "list_id": listId,
				  "title": line.to_s
				},
				counter.to_s)
		  	counter = counter + 1
	  end
	end
rescue Exception => e 
	puts "[!] Error reading the file in " + path.to_s +" => " + e.to_s
	exit
end	