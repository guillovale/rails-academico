class EventsController < ApplicationController
  	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:edit, :show, :new, :index]
	before_action :correct_user,   only: [:edit, :show, :index]

  # GET /events
  # GET /events.json
  def index
    #@events = Event.all
	idfactura = 0
	set_periodo
		#periodo_matricula = Control_periodo_matricula.where('cmp_status = ?', 1).first()
		@carreras = {}

		# verificar SNNA
		ingreso = Ingreso.joins(:mallacarrera).where("CIInfPer = ? and idper = ? and detalle like ?", 
												@usuario.CIInfPer, 109, "%SNNA%").order("ingreso.fecha DESC").first()
		if !ingreso.nil? and !@periodo.nil?
			#s = ingreso.mallacarrera.detalle
			#if s[0, 4] == "SNNA"
				nivelacion = aprobadosnna( (@periodo.idper), @usuario.CIInfPer)
				if !nivelacion.nil?
					if nivelacion[0]['Estado'] == 'APROBADO'
						hoy = Time.now.strftime("%Y/%m/%d")
						mallacarrera = Mallacarrera.where("idcarrera = ? and detalle not like ? and estado = ?", 
										ingreso.mallacarrera.idcarrera, "%SNNA%", 1 ).order("fecha DESC").first()
						#if !mallacarrera.nil?
					 	#	@ingreso = Ingreso.new
						#	@ingreso.idper = @periodo.idper
						#	@ingreso.idcarr = mallacarrera.idcarrera
						#	@ingreso.idmalla = mallacarrera.id
						#	@ingreso.CIInfPer = @usuario.CIInfPer
						#	@ingreso.malla = mallacarrera.anio
						#	@ingreso.fecha = hoy
						#	@ingreso.tipo_ingreso = 'SNNA'
						#	@ingreso.observacion = 'INSCRIPCIÓN POR FORMULARIO'
						#	@ingreso.save
						#end

						
				 		

					end
				end	
			#end
		end 
		@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
					@periodo.idper, @usuario.CIInfPer, 'MATRICULA').first()
		#@factura = Factura.where("idper = ? and cedula = ? and tipo_documento = ?", 
		#			@periodo.idper, @usuario.CIInfPer, 'MATRICULA').first()
		#@factura = Factura.where("id = ?", params[:factura]).first()
		if @factura
			@detalle_matriculas = Detalle_matricula.where("idfactura = ? and estado = ?",@factura.id, 1)
								.order('idcarr ,nivel, paralelo').uniq.pluck(:idcurso)
			idfactura = @factura.id
		end

		@facturas_anteriores = Factura.where("cedula = ? and id != ? ", @usuario.CIInfPer, idfactura)
		
		if @detalle_matriculas
			@events1 = Event.where(["idcurso IN (?)", @detalle_matriculas]).order('dia ,hora_inicio, hora_fin').all()
		end

		sql = "select f.hora_inicio, f.hora_fin, max(f.lunes) as Lunes, max(f.martes) as Martes, 
				max(f.miercoles) as Miercoles, max(f.jueves) as Jueves, 
				max(f.viernes) as Viernes, max(f.sabado) as Sábado
			from
			(select c.hora_inicio, c.hora_fin, c.lunes, c.martes, c.miercoles, c.jueves, c.viernes, c.sabado
			from
			(
			SELECT asignatura.NombAsig, detalle_horario.idcurso, detalle_horario.dia, 
						detalle_horario.hora_inicio, detalle_horario.hora_fin,
			if(detalle_horario.dia = 'LUNES', asignatura.NombAsig,'') as lunes,
			if(detalle_horario.dia = 'MARTES', asignatura.NombAsig,'') as martes,
			if(detalle_horario.dia = 'MIERCOLES', asignatura.NombAsig,'') as miercoles,
			if(detalle_horario.dia = 'JUEVES', asignatura.NombAsig,'') as jueves,
			if(detalle_horario.dia = 'VIERNES', asignatura.NombAsig,'') as viernes,
			if(detalle_horario.dia = 'SÁBADO', asignatura.NombAsig,'') as sabado
			FROM detalle_horario
			left JOIN curso_ofertado on curso_ofertado.id = detalle_horario.idcurso
			left join detalle_matricula on detalle_matricula.idcurso = curso_ofertado.id
			LEFT JOIN asignatura on asignatura.IdAsig = detalle_matricula.idasig
			LEFT join horario on horario.id = curso_ofertado.idhorario
			WHERE detalle_matricula.idfactura = #{idfactura}
			ORDER by detalle_horario.idcurso, detalle_horario.dia) c

			ORDER by c.hora_inicio, c.hora_fin) f
			GROUP BY f.hora_inicio, f.hora_fin"
		
			connection = ActiveRecord::Base.connection
			@events = connection.select_all(sql)
			return @events
		
  end

  # GET /events/1
  # GET /events/1.json
  def show
	#set_notasalumnoasignatura
		
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:dia, :idcurso, :hora_inicio, :hora_fin)
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

	def set_periodo
		@periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
	end

	def aprobadosnna(idper, cedula)
		idperiodo = idper - 1
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
			where notasalumnoasignatura.CIInfPer = '#{cedula}'
			and malla_carrera.detalle like '%SNNA%'
			and carrera.optativa != 1
			and ingreso.idper = 109
			GROUP BY malla_carrera.id, notasalumnoasignatura.idAsig
			ORDER BY notasalumnoasignatura.idAsig) c"
			connection = ActiveRecord::Base.connection
			nivelacion = connection.select_all(sqltotal)
			return nivelacion
	end

end
