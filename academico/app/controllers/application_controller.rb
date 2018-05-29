class ApplicationController < ActionController::Base
	#protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token, raise: false
	#protect_from_forgery with: :null_session
	include SessionsHelper
	#before_filter :set_no_cache
	def hello
		render html: "¡Hola, mundo!"
	end
	def set_no_cache
  		response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  		response.headers["Pragma"] = "no-cache"
 	 	response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	end
end
