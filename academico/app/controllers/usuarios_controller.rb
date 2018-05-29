class UsuariosController < ApplicationController
	before_action :logged_in_user, only: [:edit, :show]
	before_action :correct_user,   only: [:edit, :show]
	#before_action :crear_malla,   only: [:show]
	#before_filter :logged_in_user, only: [:edit, :show, :new]
	#skip_before_action :verify_authenticity_token
	before_filter :check_for_cancel, :only => [:edit, :update]

	def check_for_cancel
		if params[:commit] == "Cancelar"
			@usuario = Usuario.find(params[:id])
			redirect_to ver_horario_path(@usuario)
			#render 'show'
			#redirect_to session.delete(:return_to)
		end
	end


	def new
		@usuario = Usuario.new
	end

	def edit
		@usuario = Usuario.find(params[:id])
		#redirect_to(root_url)
	end

	def show
		@usuario = Usuario.find(params[:id])
		set_periodo
		idfactura = 0
		if @periodo
			@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
					@periodo.idper, @usuario.CIInfPer, 'MATRICULA').first()

			#@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
			#		@periodo.idper, @usuario.CIInfPer, 'MATRICULA').first()
			if @factura
				idfactura = @factura.id
			end

			@facturas_anteriores = Factura.where("cedula = ? and id != ? ", @usuario.CIInfPer, idfactura)
			#@facturas_anteriores = Factura.where("cedula = ? and idper != ? ", @usuario.CIInfPer, @periodo.idper)
			#OrderMailer.received.deliver_now
		end
		#session[:return_to] = request.referer
		#flash[:danger] = request.referer
	end

	def create
		@usuario = Usuario.new(user_params)
		#if @usuario.save
			      #flash[:success] = "Welcome to the Sample App!"
				flash[:danger] = "It failed."

		#	redirect_to @usuario
		#else
			render 'new'
		#end
	end

	def update
		@usuario = Usuario.find(params[:id])
		if params[:usuario][:fotografia]
			usuario_foto_blob = params[:usuario][:fotografia].read
			@usuario.update_attributes(:fotografia=>usuario_foto_blob)
		end
		if @usuario.update_attributes(user_params)
			# Handle a successful update.
			flash[:success] = "Datos actualizados!"
			redirect_to ver_horario_path(@usuario)
			# render 'show'
		else
			render 'edit'
		end
	end

	def update_password
		@usuario = Usuario.find(params[:CIInfPer])
		#if params[:usuario][:password].present? && params[:usuarios][:password_confirmation].present?
			# Sign in the user by passing validation in case their password changed
		#	bypass_sign_in(@user)
		#	redirect_to root_path
		#else
			render "editpass"
		#end
	end

	def show_image
		@user = Usuario.find(params[:id])
		send_data @user.fotografia, :type => 'image/png',:disposition => 'inline'
	end



	private

	def user_params
		params.require(:usuario).permit(:LoginUsu, :ClaveUsu, :NombInfPer, 
				:GeneroPer, :EtniaPer, :FechNacimPer, :CiudadPer, :DirecDomicilioPer,
				:Telf1InfPer, :CelularInfPer, :mailPer, :password, :password_confirmation)
	end

	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Por favor log in."
			redirect_to login_url
		end
	end

	# Confirms the correct user.
	def correct_user
		@usuario = Usuario.find(params[:id])
		redirect_to(root_url) unless current_user?(@usuario)
	end

	def set_periodo
		@periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
	end

	def crear_malla

		@periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		if @periodo_matricula
			@malla = Mallaestudiante.where('cedula = ? ', @usuario.CIInfPer).uniq.pluck(:carrera)
			if @malla.empty?
				@matricula_carrera = Matricula.select('idCarr, idPer')
							.where('CIInfPer = ?', @usuario.CIInfPer)
							.order('idCarr')
			else
				@matricula_carrera = Matricula.select('idCarr, idPer')
							.where('CIInfPer = ? and idCarr not in (?)', @usuario.CIInfPer, @malla)
							.order('idCarr')
			end
		
			if !@matricula_carrera.empty?
				tiempo_reingreso = Configuracion.where('dato = ?', 'TR').first()
				temp_carr = ''
				@matricula_carrera.each do |matricula|
					ultimo_periodo = matricula.periodolectivo.DescPerLec 
					anio_malla = Mallacurricular.where("idCarr = ? and status = ?", matricula.idCarr, 1)
							.order('anio_habilitacion DESC').first()#.uniq.pluck(:anio_habilitacion)
					hoy = Time.current.year
					if (hoy - ultimo_periodo[0..3].to_i) <=  tiempo_reingreso.valor
						if matricula.idCarr != temp_carr
							nueva_malla = Mallaestudiante.new
							nueva_malla.cedula = @usuario.CIInfPer
							nueva_malla.carrera = matricula.idCarr
							if anio_malla
								nueva_malla.anio_habilitacion = anio_malla.anio_habilitacion
							else
								nueva_malla.anio_habilitacion = 2014
							end

							nueva_malla.fecha = Time.now
							if nueva_malla.save
								@malla = Mallaestudiante.
								where('cedula = ? ', @usuario.CIInfPer).uniq.pluck(:carrera)
							end
							temp_carr = matricula.idCarr
						end
					end
				end
			end

		end
	end


end
