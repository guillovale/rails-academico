class NotasalumnoasignaturasController < ApplicationController
	before_action :logged_in_user, only: [:edit, :show, :new, :agrega_asignatura, :index, :crear_matricula, :show_notas]
	before_action :correct_user,   only: [:edit, :show, :agrega_asignatura, :index, :crear_matricula, :show_notas]
	
	skip_before_action :verify_authenticity_token, raise: false
	#protect_from_forgery prepend: true, with: :exception

	#before_action :set_notasalumnoasignatura, only: [:index, :show]
	#before_action :set_periodo, only: [:crear_matricula,:show]
	#before_action :set_extension, only: [:index, :crear_matricula,:show]
	#before_filter :set_var, only: [:index, :search]
		
	def check_for_cancel
		if params[:commit] == "Back"
			@mallas = Mallacurricular.take(6)
			#redirect_to @usuario
			render 'show'
			#redirect_to session.delete(:return_to)
		end
	end


	# GET /notasalumnoasignaturas
	# GET /notasalumnoasignaturas.json
	def index
		
		set_periodo
		
		if !@periodo
			flash[:alert] = 'No hay período activo!! '
			return
		end
		
		
		periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		if !periodo_matricula
			flash[:alert] = 'No hay control período matrícula activo !!'
			return
		end
		if finalizofichase(@usuario.CIInfPer, @periodo.idper) <= 0
			link = '<a href="190.152.10.221/socioeconomica"></a>'
			flash[:alert] =  %Q[Usted debe llenar o actualizar la 
				#{view_context.link_to('Ficha socioeconómica ', 'http://190.152.10.221/socioeconomica')}  
					solicitada por la Unidad de Bienestar Estudiantil.!!].html_safe
			return
		end
		set_factura
		if pago_pendiente
			flash[:alert] = 'Usted tiene valores pendientes de pago!!'
			return
		end 
		@malla_mostrar = {} 
		@carreras = Ingreso.where(CIInfPer: @usuario).order(:idcarr).select(:idcarr).uniq
		hoy = Time.now.strftime("%Y/%m/%d")
		set_notasalumnoasignatura
		ficha_medica = @usuario.entregofichamedica
		
		if ficha_medica == 0
			flash[:alert] = 'Si eres de primer semestre dirígete a Bienestar Universitario !!'
			@carreras = nil
			return
		end	

		search
		
		@periodo?(idperiodo = @periodo.idper):(idperiodo = 0)
		
		#(@extension_mat.exists?)?(ext_ced = @extension_mat.cedula):(ext_ced = 0)
		@asig_matriculadas = get_asignaturas_matricula
		@num_matricula_permitido = (Configuracion.where("dato = ?", 'NR')).uniq.pluck(:valor).first()
		@num_credito_permitido = (Configuracion.where("dato = ?", 'MC')).uniq.pluck(:valor).first()
		
		vrepite = 0
		
		if (@malla_estudiante) or (@malla_estudiante && get_extension)
			#@malla = Mallaestudiante.where({cedula: @usuario, carrera: malla_estudiante['carrera']}).first()
			@get_extension = get_extension
			@anio= @malla_estudiante["malla"]
			nivel = @nivel #@malla_estudiante["nivel"]
			id_carrera = @malla_estudiante["idcarr"]
			idmalla = @malla_estudiante["idmalla"]
			paralelo = {}
			if nivel == 'todos'
				nivel = ['1','2','3','4','5','6','7','8','9','10']
			end
			if nivel == 0 || nivel.nil? || nivel == ''
				nivel = -1
			end
			if id_carrera
				@carrera = (Carrera.where("idCarr = ?",id_carrera).first())				
			end
			
			#@matricula_actual = Matricula.where("idcarr = ? and idper = ? ", 
			#id_carrera, periodo.idper)	
			#@mallas_total = Mallacurricular.where("anio_habilitacion = ? and idCarr = ? and imp = ? and status = ?", 
			#				@anio,id_carrera,1, 1)
			#@mallas_total = Mallacarrera.where("id = ?", idmalla)
			@mallas_total = Detallemalla.where("idmalla = ? and estado = ?",
							idmalla,1)

			@mallas = Detallemalla.where("idmalla = ? and nivel in (?) and estado = ?",
							idmalla,nivel,1)
			
			
			if @mallas.exists? #&& notas.exists?
				#@mallas = @mallas.sort_by {|vn| vn['idSemestre']}
				if ( (permitir_matricula(@mallas_total, @notas_reprobadas, @num_matricula_permitido)) || 
						get_extension  || ( @carrera.optativa == true ) )
					

					@mallas.each do |malla|
						nombre_asig = ''
						@asig_pre = nil					
						#asignatura = Asignatura.where(idasig: malla.idasignatura).first()
						vrepite = @notas_reprobadas.count(malla.idasignatura)
						malla_asignada = 0
					
						#if asignatura
						#	nombre_asig = asignatura.NombAsig
						#end
					
					
						if @notas_aprobadas.find {|s| s == malla.idasignatura }
							@malla_mostrar.merge!({malla.idasignatura=>{
								'idcarr'=>malla.mallacarrera.idcarrera,
								'nivel'=>malla.nivel.to_i,
								'credito'=>malla.credito.to_i, 
								'aprobada'=> 'a', 'vrepite'=> vrepite, 
								'asignatura'=> malla.asignatura.NombAsig, 'prerequisito'=> nil, 
								'costo'=> 0, 'curso'=> nil}})
							malla_asignada = 1
							#@notas_aprobadas.delete(malla.idAsig)		
						end
						
						#if malla_asignada == 0 && @notas_matriculadas.find {|s| s. idAsig == malla.idasignatura }
						#	paralelo = get_paralelo(idperiodo, malla.id)
						#	costo_credito = (Configuracion.where("id = ?", (vrepite + 1))).uniq.pluck(:valor).first()
						#	if !costo_credito
						#		costo_credito = 0
						#	end
						#	@malla_mostrar.merge!({malla.idasignatura=>{
						#		'idcarr'=>malla.mallacarrera.idcarrera,
						#		'nivel'=>malla.nivel.to_i,
						#		'credito'=>malla.credito.to_i, 
						#		'aprobada'=> 'm', 'vrepite'=> vrepite, 
						#		'asignatura'=> nombre_asig, 'prerequisito'=> nil, 
						#		'costo'=> costo_credito, 'paralelo'=> paralelo}})
						#	malla_asignada = 1
							
						#end
						
						if malla_asignada == 0 && (prerequisitos = Mallarequisito.where(idmalla: malla.id, tipo: 'PR'))
							prerequisitos.each do |pre|
								idprerequisito = Detallemalla.where(id: pre.idmallarequisito).first()
							
								if idprerequisito
									nota_pre = @notas_aprobadas.find {|s| s == idprerequisito.idasignatura }
									#nota_pre = @notas_aprobadas.find {|s| s == pre.idmallarequisito }
								end
					
								if !nota_pre && idprerequisito
									@asig_pre = idprerequisito.idasignatura
									@malla_mostrar.merge!({malla.idasignatura=>{
										'idcarr'=>malla.mallacarrera.idcarrera,
										'nivel'=>malla.nivel.to_i,
										'credito'=>malla.credito.to_i, 
										'aprobada'=> 'p', 'vrepite'=> vrepite, 
										'asignatura'=> malla.asignatura.NombAsig, 'prerequisito'=> @asig_pre, 
										'costo'=> 0, 'curso'=> nil}})
									malla_asignada = 1
									break								
								end
							end
						end

						if malla_asignada == 0
						
							costo_credito = (Configuracion.where("id = ?", (vrepite + 1))).uniq.pluck(:valor).first()
							if !costo_credito
								costo_credito = 0
							end
							curso = get_curso(idperiodo, malla.id, vrepite)
							@malla_mostrar.merge!({malla.idasignatura=>{
								'idcarr'=>malla.mallacarrera.idcarrera,
								'nivel'=>malla.nivel.to_i,
								'credito'=>malla.credito.to_i, 
								'aprobada'=> 'n', 'vrepite'=> vrepite, 
								'asignatura'=> malla.asignatura.NombAsig, 'prerequisito'=> nil, 
								'costo'=> costo_credito, 'curso'=> curso}})
						end

					end

					@malla_mostrar = @malla_mostrar.sort_by {|vn| vn[1]['nivel']}
				else
					
					flash[:alert] = 'El número de asignaturas reprobadas sobrepasa el permitido !! '
				end
			end			

		end		

	end

	# GET /notasalumnoasignaturas/1
	# GET /notasalumnoasignaturas/1.json
	def show
		#set_notasalumnoasignatura
		#set_periodo
		#periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		@carreras = {}
		#@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
		#			@periodo.idper, @usuario.CIInfPer, 'MATRICULA').first()
		@factura = Factura.where("id = ?", params[:factura]).first()
		if @factura
			@detalle_matriculas = Detalle_matricula.where("idfactura = ? and estado = ?",@factura.id, 1)
								.order('idcarr ,nivel, paralelo')	
		end
		
		if @detalle_matriculas
			@detalle_matriculas.each do |matricula|
				if !matricula.nil?
					if !@carreras.include?(matricula.idcarr) 
						carrera = Carrera.where("idCarr = ?",matricula.idcarr).first()
						@carreras.merge!({matricula.idcarr=>carrera.NombCarr})
						#@carreras.merge!({matricula.carrera.NombCarr})
					
					end
				end 
			end
		end

	end

	def show_notas
		set_periodo
		if !@periodo.nil?
			sqltotal = "select c.periodo, c.carrera, c.peso, c.cedula, c.nombre, c.idPer, c.tipo_ingreso,
				round(sum(c.nota*c.peso/100), 2) as sumaNota, round(sum(c.maxasistencia*c.peso/100), 0) as sumaAsistencia, 
				if( (round(sum(c.nota*c.peso/100), 2) >= 8 
								 and round(sum(c.maxasistencia*c.peso/100), 0) >= 70 ), 
								'APROBADO', 'REPROBADO' ) AS Estado
				FROM
				(
				SELECT periodolectivo.DescPerLec as periodo, notasalumnoasignatura.idPer,
				carrera.NombCarr as carrera,
				detalle_malla.peso, ingreso.tipo_ingreso,
				notasalumnoasignatura.CIInfPer as cedula, concat(informacionpersonal.ApellInfPer, ' ',
				informacionpersonal.ApellMatInfPer, ' ', 
				informacionpersonal.NombInfPer) as nombre, notasalumnoasignatura.idnaa,
				notasalumnoasignatura.idAsig, notasalumnoasignatura.CalifFinal, notasalumnoasignatura.asistencia,
				max(notasalumnoasignatura.CalifFinal) as nota, max(notasalumnoasignatura.asistencia) as maxasistencia
				#detalle_malla.peso
				FROM notasalumnoasignatura
				LEFT JOIN periodolectivo on periodolectivo.idper = notasalumnoasignatura.idPer
				LEFT JOIN informacionpersonal on informacionpersonal.CIInfPer = notasalumnoasignatura.CIInfPer
				LEFT JOIN ingreso on ingreso.CIInfPer = notasalumnoasignatura.CIInfPer
				#LEFT JOIN curso_ofertado on curso_ofertado.id = detalle_matricula.idcurso
				LEFT JOIN malla_carrera on malla_carrera.id = ingreso.idmalla
				LEFT JOIN detalle_malla on detalle_malla.idasignatura = notasalumnoasignatura.idAsig
				LEFT JOIN carrera on carrera.idCarr = ingreso.idcarr
				where notasalumnoasignatura.CIInfPer = '#{@usuario.CIInfPer}'
				and malla_carrera.detalle like '%SNNA%'
				and carrera.optativa != 1
				and ingreso.idper = #{@periodo.idper - 1}
				GROUP BY malla_carrera.id, notasalumnoasignatura.idAsig
				ORDER BY notasalumnoasignatura.idAsig) c"

			connection = ActiveRecord::Base.connection
			@nivelacion = connection.select_all(sqltotal)
		end
		#if evaluo_docente(@usuario.CIInfPer, @periodo.idper) > 0
		#	flash[:alert] =  %Q[Para visualizar sus calificaciones, debe realizar la  
		#		#{view_context.link_to('Evaluación Docente', 'http://190.152.10.221/evaldocentesiad')}  
		#			estipulada en el Calendario Académico IIS-2017.!!].html_safe
		#	return
		#end	
		set_notasalumnoasignatura
		#@periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		@carreras = {}
				
		if @notasalumnoasignatura
			@notasalumnoasignatura.each do |nota|
				if !nota.matricula.nil?
					if !@carreras.include?(nota.matricula.idCarr) 
						carrera = Carrera.where("idCarr = ?",nota.matricula.idCarr).first()
						@carreras.merge!({nota.matricula.idCarr=>carrera.NombCarr})
					
					end
				elsif !nota.iddetalle.nil? and !nota.detallematricula.nil?
					carrera = Carrera.where("idCarr = ?",nota.detallematricula.idcarr).first()
						@carreras.merge!({nota.detallematricula.idcarr=>carrera.NombCarr})
				end 
			end
		end

	end

	# GET /notasalumnoasignaturas/new
	def new
		#@notasalumnoasignatura = Notasalumnoasignatura.new
	end

	# GET /notasalumnoasignaturas/1/edit
	def edit
	end

	# POST /notasalumnoasignaturas
	# POST /notasalumnoasignaturas.json
	def create
		#@notasalumnoasignatura = Notasalumnoasignatura.new(notasalumnoasignatura_params)

		respond_to do |format|
			if true #@notasalumnoasignatura.save
				format.html { redirect_to @notasalumnoasignatura, notice: 'Notasalumnoasignatura was successfully created.' }
				format.json { render :show, status: :created, location: @notasalumnoasignatura }
			else
				format.html { render :new }
				format.json { render json: @notasalumnoasignatura.errors, status: :unprocessable_entity }
			end
		end
	end

	def crear_matricula
		set_periodo
		#set_extension
		@periodo?(idperiodo = @periodo.idper):(idperiodo = 0)
		@asig_matriculadas = get_asignaturas_matricula
		#@matricula = ''
		@num_credito_permitido = (Configuracion.where("dato = ?", 'MC')).uniq.pluck(:valor).first()
		hoy = Time.now.strftime("%Y/%m/%d")
		periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		valor_matricula = 0

		if (@asig_matriculadas && !periodo_matricula.nil?) or (@asig_matriculadas && get_extension && !periodo_matricula.nil?)
			if (periodo_matricula.cmp_tipo2 == 'EXTRAORDINARIA') 
				valor_matricula = (Configuracion.where("dato = ?", 'MX')).uniq.pluck(:valor).first()
			end
			if (periodo_matricula.cmp_tipo2 == 'ESPECIAL') 
				valor_matricula = (Configuracion.where("dato = ?", 'ME')).uniq.pluck(:valor).first()
			end
			@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
					idperiodo, @usuario.CIInfPer, periodo_matricula.cmp_tipo).first()
			
			if !@factura
				@factura = Factura.new
				@factura.cedula = @usuario.CIInfPer
				@factura.idper = idperiodo
				@factura.tipo_documento = periodo_matricula.cmp_tipo
				@factura.fecha = Time.now
				@factura.valor_matricula = valor_matricula
				@factura.total = valor_matricula.round(2)
				@factura.observacion = periodo_matricula.cmp_tipo2
				@factura.save
			end

			#suma_total1 = @asig_matriculadas.map {|s| s[1]['costo'].to_f}.sum
			suma_total = 0
			if @factura
				@asig_matriculadas.each do |asig|
					#suma_total = (suma_total + asig[1]['costo'].to_i * asig[1]['credito'].to_i).round(2)
					#if asig[1]['matriculada'] == 'N'
					idcurso = asig[1]['idcurso']
					curso = Cursoofertado.where("id = ?", idcurso).first()
					#nota_matriculada = nil
					
					#carrera = asig[1]['carrera']
					#asignatura = asig[0]
					#nivel = asig[1]['nivel']
					#horario = asig[1]['horario']
					#credito = asig[1]['credito']
					
					
					##################	
					if !curso.nil?
						carrera = (curso.detallemalla.mallacarrera)?(curso.detallemalla.mallacarrera.idcarrera):('')
						asignatura = (curso.detallemalla)?(curso.detallemalla.idasignatura):('')
						nivel = (curso.detallemalla)?(curso.detallemalla.nivel):('')
						paralelo = (curso)?(curso.paralelo):('')
						repite = asig[1]['vrepite']
						costo = asig[1]['costo']
						credito = (curso.detallemalla)?(curso.detallemalla.credito):('')
						detalle_matriculada = Detalle_matricula.where("idfactura = ? and idcurso = ? ",
								@factura.id, curso.id).first()
						if !detalle_matriculada
							@detalle_mat = Detalle_matricula.new
							@detalle_mat.idfactura = @factura.id
							@detalle_mat.idcurso = curso.id
							@detalle_mat.idasig = asignatura
							@detalle_mat.idcarr = carrera
							@detalle_mat.nivel = nivel
							@detalle_mat.paralelo = paralelo
							#@detalle_mat.idnota = idnota
							@detalle_mat.credito = credito
							@detalle_mat.vrepite = repite
							@detalle_mat.costo = costo
							#@detalle_mat.horario = horario
							@detalle_mat.fecha = Time.now.strftime("%Y/%m/%d")
							@detalle_mat.estado = 1
							@detalle_mat.save
							#if @detalle_mat.save
							#		@matricula = @detalle_mat.id
									#asig[1]['matriculada'] = 'S'
							#else
							#	@matricula = nil 
								#nota.errors.full_messages
								#idnota = nil
							#end
							#@detalle_mat.save
							#	suma_total = (suma_total + asig[1]['costo'].to_i * asig[1]['credito'].to_i).round(2)
							#end
						else # detalle_matriculada
							#@matricula = detalle_matriculada.id
							detalle_matriculada.idcurso = curso.id
							detalle_matriculada.idasig = asignatura
							detalle_matriculada.nivel = nivel
							detalle_matriculada.paralelo = paralelo
							detalle_matriculada.credito = credito
							detalle_matriculada.vrepite = repite
							detalle_matriculada.costo = costo
							detalle_matriculada.estado = 1
							detalle_matriculada.save
						#else
						#	@detalle_mat = nil
							#@matricula = nil
						end
					end

				end
				
				total = Detalle_matricula.where("idfactura = ? and estado = 1",
							@factura.id).sum("credito * costo")
				if total >= 0 then
				#(suma_total + @factura.iva - @factura.descuento ).round(2)
					@factura.valor_credito = total.round(2)
					@factura.total = @factura.valor_matricula + total.round(2)
					@factura.save
					reset_asignatura
				end
				#if @factura.save
				#	reset_asignatura			
				redirect_to :action => "show", :factura => @factura.id
					#format.json { render :show, status: :created, location: @notasalumnoasignatura }
				#else
				#	redirect_to :back
					#render :index
				#end
			else
				redirect_to :back
				#render :index
				#format.json { render json: @notasalumnoasignatura.errors, status: :unprocessable_entity }
			end
		
			#@notasalumnoasignatura = Notasalumnoasignatura.where("CIInfPer = ?", params[:CIInfPer]).first()
		else
			redirect_to :back
		end
		#render :indexx
	end


	# PATCH/PUT /notasalumnoasignaturas/1
	# PATCH/PUT /notasalumnoasignaturas/1.json
	def update
		respond_to do |format|
			if @notasalumnoasignatura.update(notasalumnoasignatura_params)
				format.html { redirect_to @notasalumnoasignatura, notice: 'Notasalumnoasignatura was successfully updated.' }
				format.json { render :show, status: :ok, location: @notasalumnoasignatura }
			else
				format.html { render :edit }
				format.json { render json: @notasalumnoasignatura.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /notasalumnoasignaturas/1
	# DELETE /notasalumnoasignaturas/1.json
	def destroy
		@notasalumnoasignatura.destroy
		respond_to do |format|
			format.html { redirect_to notasalumnoasignaturas_url, notice: 'Notasalumnoasignatura was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	def borra_matricula
		#set_notasalumnoasignatura
		set_periodo
		periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		#carreras = {}
		factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
					@periodo.idper, @usuario.CIInfPer, periodo_matricula.cmp_tipo).first()
		
		if factura
			detalle_matriculas = Detalle_matricula.where("idfactura = ?",factura.id)
								.order('idcarr ,nivel, paralelo')	
		end
		
		if detalle_matriculas
			detalle_matriculas.each do |matricula|
				if !matricula.nil?
					matricula.destroy
				end 
			end
		end

	end

	# agrega asign. a pre matrícula
	def agrega_asignatura
		if params[:idasignatura]
			mallas = params[:idasignatura]
			mallas.each do |malla|
				#eval(id[0])[eval(id[0]).keys*',']
				@idasig = eval(malla).keys*","
				dato = eval(malla)[@idasig]
				asig_max = 11
				#curso_id = params[:curso][dato['contador']-1]
				if params[:curso][dato['contador']-1]
					idcurso = params[:curso][dato['contador']-1]
				elsif params[:curso][dato['contador']-2]
					idcurso = params[:curso][dato['contador']-2]
				end
				if dato['vrepite'] > 2
					asig_max = 5
				end
				#idcurso = params[:curso][dato['contador']-1]?params[:curso][dato['contador']-1]:params[:curso][dato['contador']-2]:0
			
				if dato && get_asignaturas_matricula.count < asig_max && (horario_libre(idcurso) == 0) && idcurso.to_i > 0
			
					idmalla = @idasig
					#nombre = dato['asignatura']# params[:paralelo] #asignatura[:nombre]
					carrera = params[:idcarr]
					nivel = dato['nivel']
					costo = dato['costo'] #asignatura[:costo]
					#idcurso = (params[:curso])?params[:curso][dato['contador']-1]:'' #paralelo #asignatura[:paralelo]
					credito = dato['credito'] #asignatura[:credito]
					vrepite = dato['vrepite']#asignatura[:vrepite]
					#horario = 1 #asignatura[:@horario]
					#idcurso = (params[:paralelo])?params[:paralelo][dato['contador']-2]:''
			
					malla_agregar = {idmalla => {'carrera'=>carrera,
								'vrepite'=>vrepite, 
								'nivel'=>nivel, 
								'costo'=> costo,
								'credito'=>credito, 
								#'horario'=>horario, 
								#'paralelo'=>paralelo,
								'idcurso'=>idcurso, 
								#'matriculada'=>'N'
						}}
					#if malla.blank?
						store_asignaturas_matricula(malla_agregar)
					#end
					#redirect_to action: 'index'
				end

				if horario_libre(idcurso) > 0
					flash[:alert] = 'Tiene cruce de horario con curso. ' + horario_libre(idcurso).to_s
				end

			end
			
		end
		redirect_to action: 'index'



	end

	# quita asign. a pre matrícula
	def quitar_asignatura
		idmalla = params[:id].delete('.', ',')
		quita_asignatura(idmalla)
		redirect_to action: 'index'
		
	end

	# ---------------------------------------------------------------------------------------------------------------------------	
	private

		# Use callbacks to share common setup or constraints between actions.
		def set_periodo
			@periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
		end
	
		def set_factura
			set_periodo
			periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
			if @periodo
				@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
					@periodo.idper, @usuario.CIInfPer, periodo_matricula.cmp_tipo).first()
				#@factura = Factura.where("idper = ? and cedula = ? ", 
				#		@periodo.idper, @usuario.CIInfPer).first()
		
				if @factura
					@detalle_matriculas = Detalle_matricula.where("idfactura = ? and estado = ?",@factura.id, 1)
										.order('idcarr ,nivel, paralelo')	
				end
			end

		end

		# Use callbacks to share common setup or constraints between actions.
		def set_notasalumnoasignatura
			@notasalumnoasignatura = Notasalumnoasignatura.
									where("CIInfPer = ?", @usuario)
			# @periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
			if @notasalumnoasignatura
				#set_periodo
				@notas_aprobadas = []
				@notas_reprobadas = []
				#@notas_matriculadas = []
				@notas_equiparadas = []
				
				
				@notasalumnoasignatura.each do |nota|
					if nota.aprobada == true
						@notas_aprobadas << nota.idAsig
						equivalencias = Equivalencia.where("equivalencia = ?",nota.idAsig)
						if equivalencias
							equivalencias.each do |equival|
								if nota.idAsig != equival.asignatura
									@notas_aprobadas << equival.asignatura
									#@notas_equiparadas << equival.asignatura
								end
							end
						end
					end
					
					#if nota.aprobada == false and nota.StatusCalif == 1 and nota.idPer == @periodo.idper
					#	@notas_matriculadas << nota #.idAsig
					#	@idfactura ||= nota.idMc
											
					#end
				end

				@notasalumnoasignatura.each do |nota|
				
					if nota.aprobada == false #and nota.idPer != @periodo.idper
						@notas_reprobadas << nota.idAsig unless @notas_aprobadas.include?(nota.idAsig)
					end
				end
			end

		
		end

		def get_extension
			set_periodo
			if @periodo
				hoy = Time.now.strftime("%Y/%m/%d")
				#@periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
				extension_mat = Extension_matricula.where("idper = ? and cedula = ? and 
								fechain <= (?) and fechafin >= ?", 
								@periodo.idper,@usuario,hoy,hoy)
				if extension_mat.count > 0
					return true
				end
			end
			return false
		end

		def permitir_matricula(mallas, notas_reprobadas, num_matricula_permitido)
			vrepite = 0
			mallas.each do |malla|
				vrepite = notas_reprobadas.count(malla.idasignatura)
				if vrepite > num_matricula_permitido
					return  false
				end
			end
			return true
			
		end

		def pago_pendiente()
			set_periodo
			if @periodo
				facturas = Factura.where("cedula = ? and idper != ?", 
						@usuario.CIInfPer, @periodo.idper)
		
				if facturas
					facturas.each do |factura|
						suma_abono = Abonofactura.where("idfactura = ?",factura.id).sum("valor")
						if (factura.total.round(2) - suma_abono.round(2) - 0.02 > 0)
							return  true
						end
					
					end
				end
			end
			return false
		end


	# Never trust parameters from the scary internet, only allow the white list through.
	def notasalumnoasignatura_params
		params.require(:notasalumnoasignatura).permit(:idnaa, :CIInfPer, :idAsig, :idPer)
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Por favor log in."
			redirect_to login_url
		end
	end

	# Confirms the correct user.
	def correct_user
		@usuario = Usuario.find(params[:CIInfPer])
		redirect_to(root_url) unless current_user?(@usuario)
	end
	
	def evaluo_docente(cedula, periodo)
		date = Date.parse '2018-03-14'
		sql = 'select count(*)     
			from (
			SELECT  detalle_matricula.idasig 
			FROM     siad.detalle_matricula, siad.factura, siad.curso_ofertado                        
			where     factura.id=detalle_matricula.idfactura
					and curso_ofertado.id=detalle_matricula.idcurso                      
					and factura.tipo_documento="MATRICULA"
					and factura.idper = ' + periodo.to_s +
					' and factura.cedula= ' + '"' + cedula + '"' +  
					' and length(curso_ofertado.iddocente)>0
					and detalle_matricula.estado = 1
					and curso_ofertado.fecha_fin<=date
					and detalle_matricula.idasig not in 
						(SELECT evaldocente.materia_id FROM siad.evaldocente where evaldocente.periodo_id= ' + 
						periodo.to_s + ' and
							evaldocente.cedula_estudiante= ' + '"' + cedula + '"' + ')
					)todo'

		results = ActiveRecord::Base.connection.execute(sql)
        if results.present?
            return results.first[0]
        else
            return 1000
        end

		#@usuario = Usuario.find(params[:CIInfPer])
		#unless logged_in?
		#	store_location
		#	flash[:danger] = "Por favor log in."
		#	redirect_to login_url
		#end
	end

	def finalizofichase(cedula, periodo)
		date = Date.parse '2018-03-14'
		sql = 'SELECT count(ciinfper) FROM siad.fichasocioeconomica where CIInfPer in (' + '"' + cedula + '"' +
					') and idper = ' + periodo.to_s

		results = ActiveRecord::Base.connection.execute(sql)
        if results.present?
            return results.first[0]
        else
            return 0
        end

		#@usuario = Usuario.find(params[:CIInfPer])
		#unless logged_in?
		#	store_location
		#	flash[:danger] = "Por favor log in."
		#	redirect_to login_url
		#end
	end

	def search
		
		if params[:carrera] 
			
			@idcarrera = params[:carrera]
			@nivel = params[:nivel]
			@cedula = params[:CIInfPer]
			#@paralelo = params[:paralelo]
			#@malla_estudiante = Mallaestudiante.where({cedula: @cedula, carrera: @idcarrera}).first()
			@malla_estudiante = Ingreso.where({CIInfPer: @usuario, idcarr: @idcarrera}).order("idper DESC").first()
		end
		#return malla_estudiante
		#redirect_to action: 'index'
	end

	def get_paralelos(idper, idcarr, nivel, idasig)
		cupo = Cupo.where("idper = ? and idCarr = ? and idsemestre = (?) ", 
						idper, idcarr,nivel).first()
		paralelo = {}

		if cupo
			paralelos = ("A".."B1").to_a
			total_cupo = cupo.cc_cupo
			total_paralelo = cupo.cc_num_paralelos - 1
			total_aula = cupo.cc_estudiantesxaula
			cont = 0
			total_matriculados = 0						
			(0..total_paralelo).each do |n|
				 # paralelo << paralelos[n]
				matriculas = Matricula.where("idcarr = ? and idper = ? and idsemestre = (?) and idparalelo = ?", 
								cupo.idcarr, cupo.idper, cupo.idsemestre, 
								paralelos[n]).uniq.pluck(:idmatricula)
				if matriculas
					detalle_matriculas = Detalle_matricula.where("idmatricula in (?) and idasig = ?", 
							matriculas, idasig)
					if  detalle_matriculas
						total_matriculados = detalle_matriculas.count()	
					end
					#total_matriculados = matriculas.count()
				end

				num_cupos = 0
				#matricula_nivel = matriculas.find {|m| m.idParalelo == paralelos[n] }
				num_cupos = total_aula - total_matriculados
				if num_cupos > 0
					paralelo.merge!({paralelos[n]=>{'cupo'=>num_cupos, 'horario'=>total_matriculados}})
				end
			end
		end
		return paralelo
	end
	
	def get_matricula(max, periodo, carrera, nivel)
		i = 1
		num = 1000
		begin
			maximo = max.to_i + i
			maximo = maximo.to_s
			maximo = (maximo.length >= 3)?maximo:((maximo.length == 2)?('0'+ maximo):('00'+ maximo))
			matricula = periodo + carrera + ((nivel >= 10)?(nivel.to_s):('0' + nivel.to_s)) + maximo
			id_mat = Matricula.where("idMatricula = ?", matricula).first()
			i +=1
			
		end until i > num || !id_mat

		if 	id_mat
			return nil
		else
			return matricula
		end

	end

	def get_paralelo1(idper, idcarr, nivel, idasig)
		#cupo = Cupo.where("idper = ? and idCarr = ? and idsemestre = (?) ", 
		#				idper, idcarr,nivel).first()
		paralelo = {}

		#if cupo
			#paralelos = ("A".."B1").to_a
			detalle_paralelo = Detalleparalelo.where("idcarr = ? and idper = ? and nivel = (?) 
								and idasig = ? and habilitado = ?", 
								idcarr, idper, nivel, idasig, 1)
			#total_cupo = cupo.cc_cupo
			#total_paralelo = cupo.cc_num_paralelos - 1
			#total_aula = cupo.cc_estudiantesxaula
			#cont = 0
			total_matriculados = 0
			facturas = Factura.where("idper = ?",idper).uniq.pluck(:id)
			if detalle_paralelo
				detalle_paralelo.each do |paral|
					
					total_matriculados = 
						Detalle_matricula.where("idcarr = ? and idfactura in (?) 
							and nivel = (?) and paralelo = ? and idasig = (?)", 
						idcarr, facturas, nivel, paral.paralelo.paralelo, idasig).count()
					num_cupos = 0
					#matricula_nivel = matriculas.find {|m| m.idParalelo == paralelos[n] }
					num_cupos = paral.cupo - total_matriculados
					#num_cupos = total_matriculados
					if num_cupos > 0
						paralelo.merge!({paral.paralelo.paralelo=>{'cupo'=>num_cupos, 'horario'=>total_matriculados}})
					end
				end
			end
		#end

		return paralelo
		
	end

	def get_curso(idper, iddetallemalla, vrepite)
		
		cursos = {}
		restringido = false
		hoy = Time.now.strftime("%Y/%m/%d")
		if vrepite > 0
			detalle_curso = Cursoofertado.where("idper = ? and iddetallemalla = ? and restringido = ? 
						and fecha_fin >= ?",	idper, iddetallemalla, false, hoy).order('paralelo')
		else
			detalle_curso = Cursoofertado.where("idper = ? and iddetallemalla = ? and fecha_fin >= ?", 
								idper, iddetallemalla, hoy).order('paralelo')
		end

		#detalle_curso = Cursoofertado.where("idper = ? and iddetallemalla = ? and restringido = ?", 
		#						idper, iddetallemalla, false).order('paralelo')
		total_matriculados = 0
		if detalle_curso
			detalle_curso.each do |curso|
				total_matriculados = Detalle_matricula.where("idcurso = (?)", curso.id).count()
				num_cupos = 0
				num_cupos = curso.cupo - total_matriculados
				if num_cupos > 0 && curso.id > 0
					cursos.merge!({curso.id=>{'cupo'=>num_cupos, 'horario'=>total_matriculados, 'paralelo'=>curso.paralelo}})
				end
			end
		end

		return cursos
		
	end	

	def horario_libre(idcurso)
		libre = 0

		detalle_horario1 = Detallehorario.where("idcurso = ?", 
								idcurso)
		curso1 = Cursoofertado.where("id = ?", idcurso).first()
		
		if detalle_horario1 && curso1
			asignaturas_matriculadas = get_asignaturas_matricula
			if asignaturas_matriculadas.count > 0
				asignaturas_matriculadas.each do |asignatura|
					curso2 = Cursoofertado.where("id = ?", 
								asignatura[1]['idcurso']).first()
					detalle_horario2 = Detallehorario.where("idcurso = ?", asignatura[1]['idcurso'])
					if detalle_horario2 && curso2
						#if curso1.iddetallemalla != curso2.iddetallemalla
							detalle_horario2.each do |horario2|
								detalle_horario1.each do |horario1|
									if (horario2.dia == horario1.dia && 
										!(horario1.hora_fin <= horario2.hora_inicio || horario1.hora_inicio >= horario2.hora_fin))
										return curso2.id
									end
								end
							end
						#end
					end
				end
			end
		end

		set_factura
		if @detalle_matriculas && detalle_horario1 && curso1
			@detalle_matriculas.each do |asignatura|
				curso2 = Cursoofertado.where("id = ?", asignatura.idcurso).first()
				detalle_horario2 = Detallehorario.where("idcurso = ?", asignatura.idcurso)
				if detalle_horario2 && curso2
					#if curso1.iddetallemalla != curso2.iddetallemalla
						detalle_horario2.each do |horario2|
							detalle_horario1.each do |horario1|
								if (horario2.dia == horario1.dia && 
									!(horario1.hora_fin <= horario2.hora_inicio || horario1.hora_inicio >= horario2.hora_fin))
									return curso2.id
								end
							end
						end
					#end
				end
			end
		end
		

		return libre
		
	end	

end
