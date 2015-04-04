require 'net/http'
require 'net/https'
require 'uri'

require 'json'

module Glowfish
	class API
		@@url 	= "https://api.glowfi.sh/"
		@@v   	= "v1"
		
		def initialize(sid = nil, token = nil)
			@sid = sid
			@token = token
		end
			
		def train(data_set = {}, response = {}, params = {})
			data = Hash.new("data")
			data = {"data_set" => data_set, "response" => response}
			data.merge!(params)
		
			return _request("train", data)
		end
		
		def predict(data_set = {}, response = nil, params = {})
			data = Hash.new("data")
			data = {"data_set" => data_set, "response" => response}
			data.merge!(params)
		
			return _request("predict", data)
		end
		
		def cluster(data_set = {}, params = {})
			data = Hash.new("data")
			data = {"data_set" => data_set}
			data.merge!(params)
		
			return _request("cluster", data)
		end
		
		def feature_select(data_set = {}, response = nil, params = {})
			data = Hash.new("data")
			data = {"data_set" => data_set, "response" => response}
			data.merge!(params)
		
			return _request("feature_select", data)
		end
		
		def filter_train(userids = [], productids = [], ratings = [], params = {})
			data = Hash.new("data")
			data = {"userid" => userids, "productid" => productids, "ratings" => ratings}
			data.merge!(params)
		
			return _request("filter_train", data)
		end
		
		def filter_predict(userids = [], productids = [], ratings = [], params = {})
			data = Hash.new("data")
			data = {"userid" => userids, "productid" => productids, "ratings" => ratings}
			data.merge!(params)
		
			return _request("filter_predict", data)
		end
		
		private
		
		def _request (endpoint, data)		
			url = URI.parse("#{@@url}#{@@v}/#{endpoint}/")
			req = Net::HTTP::Post.new(url.path, initheader = {'Content-Type' =>'application/json'})
			req.basic_auth @sid, @token
			#req.set_form_data(data.to_json)
			req.body = data.to_json
			
			sock = Net::HTTP.new(url.host, url.port)
			sock.use_ssl = true
			res = sock.start {|http| http.request(req) }
			
			begin
				result = JSON.parse(res.body)
			rescue JSON::ParserError => e  
				return Response.new(400, "Unknown error occurred", nil, e, nil)
			end
			
			metrics = nil
			if result.has_key? 'result' and result['result'].has_key? 'metrics'
				metrics = result['result']['metrics']
			end
			
			if result.has_key? 'status' and result['status'].has_key? 'code'
				if result['status']['code'].to_i < 300
					return Response.new(result['status']['code'].to_i, "Success", result['result'], nil, metrics)
				else
					if result['status'].has_key? 'codeMessage' and result.has_key? 'errors'
						return Response.new(result['status']['code'].to_i, result['status']['codeMessage'], nil, result['errors'], metrics)
					elsif result['status'].has_key? 'codeMessage'
						return Response.new(400, "Unknown connection error", nil, {"global" => result['status']['codeMessage']}, metrics)
					else
						return Response.new(400, "Unknown connection error", nil, nil, metrics)
					end
				end
			end
		end
	end
	
	class Response
		@code 		= 200
		@message 	= nil
		
		@data		= nil
		@errors		= nil
		@metrics	= nil
	
		def initialize(*args)
			@code, @message, @data, @errors, @metrics = args
		end
		
		def code
			return @code
		end
		
		def message
			return @message
		end
		
		def data
			return @data
		end
		
		def errors
			return @errors
		end
		
		def metrics
			return @metrics
		end
	end
end