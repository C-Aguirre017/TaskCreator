require 'rest-client'

$cookies = {}
$token = ""
$clientID = ""

def setClientID(client)
	$clientID = client.to_s
end

def setToken(token)
	$token = token.to_s
end

def saveCookies(response)
    response.cookies.each { | k, v |
    	$cookies[k] = v
    }
end 

def get(url)
	puts '[+] GET ' + url
	response = RestClient::Request.execute(:method => :get,
		:url => url,
	  	:headers => {
	  		'X-Access-Token' => $token.to_s,
	  		'X-Client-ID' => $clientID.to_s
	  	},
	  	:cookies => $cookies,
	  	:timeout => 10
	)

	if (response.code == 200)
	    saveCookies(response)
	    response.to_s
	else
		puts 'Error'
	end
end

def post(url,params,number)
	puts '[+] POST ' + url + ' ' + number.to_s
	#puts 'X-Access-Token: ' + $token.to_s
	#puts 'X-Client-ID: ' + $clientID.to_s 
	response = RestClient::Request.execute(:method => :post,
		:url => url,
	  	:headers => {
	  		'X-Access-Token' => $token.to_s,
	  		'X-Client-ID' => $clientID.to_s,
	  		'Content-Type' => 'application/json'
	  	},
	  	:payload => params.to_json,
	  	:cookies => $cookies,
		:timeout => 120 
	)

	if (response.code == 201)
	    saveCookies(response)
	    response.to_s		
	else
		puts 'No Entro'
	end
end