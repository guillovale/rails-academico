class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token, raise: false
	#protect_from_forgery with: :exception
	#protect_from_forgery prepend: true, with: :reset_session
	#skip_before_action :verify_authenticity_token
	#protect_from_forgery with: :null_session
	#protect_from_forgery prepend: true
	#protect_from_forgery prepend: true, with: :exception

	def new
		if logged_in? and !@usuario.nil?
			redirect_to ver_horario_path(@usuario)
			#render 'new'
		end
	end

	def create
		if (params[:session][:usuario].present? && params[:session][:password].present?)
			usuario = Usuario.find_by(CIInfPer: params[:session][:usuario])
			if usuario
				if (usuario.codigo_dactilar == Digest::MD5.hexdigest(params[:session][:password]))
					flash.now[:success] = 'log in'
					log_in usuario
					redirect_back_or ver_horario_path(usuario)
				else

					flash.now[:danger] = 'usuario/password inválido'
					render 'new'
				end
			else
				flash.now[:danger] = 'usuario/password inválido'
				render 'new'
			end

		else
			flash.now[:danger] = 'ingresar usuario/password'
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	
	end
end
