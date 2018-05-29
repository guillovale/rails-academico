module SessionsHelper
	# Logs in the given user.
	def log_in(usuario)
		session[:user_id] = usuario.CIInfPer
		session[:asignaturas] = {}
		#session[:notas] = Notasalumnoasignatura.where("CIInfPer = ?", usuario.CIInfPer)
		session[:malla_estudiante] ||= []
	end

	# Returns the current logged-in user (if any).
	def current_user
		@current_user ||= Usuario.find_by(CIInfPer: session[:user_id])
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	 # Logs out the current user.
	def log_out
		if current_user
			session.delete(:user_id)
		
			@current_user = nil
			session.delete(:asignaturas)
			session.delete(:malla_estudiante)
		end
		
	end

	# Returns true if the given user is the current user.
	def current_user?(user)
		user == current_user
	end

	# Redirects to stored location (or to the default).
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# Stores the URL trying to be accessed.
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

	def store_malla_estudiante(malla)
		session[:malla_estudiante] = malla
		#(session[:malla_estudiante]).merge!(malla)
	end

	def store_asignaturas_matricula(idmalla)
		if !session[:asignaturas].include?(idmalla)
			#session[:asignaturas] << idmalla
			(session[:asignaturas]).merge!(idmalla)
		end
	end

	def get_asignaturas_matricula
		# @asignaturas_matricula ||= []
		session[:asignaturas]
	end
	
	def get_malla_estudiante
				
		session[:malla_estudiante]
	end

	

	def quita_asignatura(idmalla)
		session[:asignaturas].delete(idmalla)
	end	

	def reset_asignatura
		session[:asignaturas].clear
	end


end
