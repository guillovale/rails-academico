class DetallematriculaController < ApplicationController
	before_action :logged_in_user, only: [:index]
	before_action :correct_user,   only: [:index]
	def index
		
		@notas_componente = {}
		notaF = 0
		total = 0
		hash = {}
		@notas_componente1 = {}
		set_periodo
		set_configuracion
		if !@periodo
			flash[:alert] = 'No hay período activo!! '
			return
		end
		@periodos = Periodolectivo.where("idper > ?", 107).order(idper: :desc).all()
		
		search
		##if evaluo_docente(@usuario.CIInfPer, @periodo.idper) > 0
		##	flash[:alert] =  %Q[Para visualizar sus calificaciones, debe realizar la
		#		#{view_context.link_to('Evaluación Docente', 'http://190.152.10.221/evaldocentesiad')}  
		#			estipulada en el Calendario Académico IIS-2017.!!].html_safe
		#	return
		#end
		#@mallaestudiante = Ingreso.where("idper = ?", @periodo.idper).order("fecha DESC").first()
		@estado_matricula = 1
		@factura = Factura.where("cedula = ? and idper = ? and tipo_documento = 'MATRICULA'", @usuario, @idperiodo).first()
		#@sumnotas = Detallematricula.where("idfactura = ?", @factura).getSumanotas('A')
		@detallematricula = Detallematricula.where("idfactura = ? and estado = ?", @factura, 1)
							.group('idcurso')
							.all()#uniq.pluck(:id)
		@notasdetalle = Notasdetalle.joins(libretacalificacion: :componentecalificacion)
						.where("iddetallematricula in (?)", @detallematricula.ids)
						.order("iddetallematricula ASC, libreta_calificacion.hemisemestre ASC, 
							componentescalificacion.idparametro ASC")
						.all()
		if !@factura.nil?
			if @factura.observacion.downcase == 'snna'
				
						sqlsnna = "SELECT c.cedula, c.nombre, c.idnota, 
							c.iddetallematricula, NombAsig,c.idAsig, c.idper,
						max(c.GA1) as GA1, max(c.NGA1) as NGA1, max(c.GA2) as GA2 , 
						max(c.NGA2) as NGA2, max(c.PA) as PA , max(c.NPA) as NPA , max(c.X1) as X1, max(c.NX1) as NX1,
						max(c.X2) as X2, max(c.NX2) as NX2,
						round((max(c.NGA1) + max(c.NGA2) + max(c.NPA) + max(c.NX1) + max(c.NX2))/5, 2) as suma, 
						max(c.M) as MJ, max(c.NM) as NM,
						max(c.AT) as AT, max(c.NAT) as NAT,
						if( max(c.NAT) >= 7 and (max(c.NM) >= 8 or (max(c.NAT) >= 7 and
								round((max(c.NGA1) + max(c.NGA2) + max(c.NPA) + max(c.NX1) + max(c.NX2))/5) >= 8)),
						 'APROBADA','REPROBADA') as Estado,
						if( max(c.NAT) >= 7 and (max(c.NM) >= 8 or (max(c.NAT) >= 7 and
								round((max(c.NGA1) + max(c.NGA2) + max(c.NPA) + max(c.NX1) + max(c.NX2))/5) >= 8)),
						 1,0) as aprobada,
						if(max(c.NM) > round((max(c.NGA1) + max(c.NGA2) + max(c.NPA) + max(c.NX1) + max(c.NX2))/5), max(c.NM),
							round((max(c.NGA1) + max(c.NGA2) + max(c.NPA) + max(c.NX1) + max(c.NX2))/5, 2)) as notafinal
						from(
						SELECT notas_detalle.idnota, libreta_calificacion.idcurso, asignatura.idAsig,factura.idper,
							libreta_calificacion.id, libreta_calificacion.idcomponente,
							notas_detalle.iddetallematricula, notas_detalle.nota, 
							if(libreta_calificacion.idcomponente = 27, notas_detalle.idnota, '') as GA1,
							if(libreta_calificacion.idcomponente = 27, notas_detalle.nota, '') as NGA1,
							if(libreta_calificacion.idcomponente = 28, notas_detalle.idnota, '') as GA2,
							if(libreta_calificacion.idcomponente = 28, notas_detalle.nota, '') as NGA2,
							if(libreta_calificacion.idcomponente = 29, notas_detalle.idnota, '') as PA,
							if(libreta_calificacion.idcomponente = 29, notas_detalle.nota, '') as NPA,
							if(libreta_calificacion.idcomponente = 30, notas_detalle.idnota, '') as X1,
							if(libreta_calificacion.idcomponente = 30, notas_detalle.nota, '') as NX1,
							if(libreta_calificacion.idcomponente = 31, notas_detalle.idnota, '') as X2,
							if(libreta_calificacion.idcomponente = 31, notas_detalle.nota, '') as NX2,
							if(libreta_calificacion.idcomponente = 32, notas_detalle.idnota, '') as M,
							if(libreta_calificacion.idcomponente = 32, notas_detalle.nota, '') as NM, 
							if(libreta_calificacion.idcomponente = 33, notas_detalle.idnota, '') as AT,
							if(libreta_calificacion.idcomponente = 33, notas_detalle.nota, '') as NAT,
							concat(informacionpersonal.ApellInfPer, ' ', informacionpersonal.ApellMatInfPer, ' ',
								informacionpersonal.NombInfPer ) as nombre, factura.cedula, asignatura.NombAsig
						FROM `notas_detalle`
						LEFT JOIN libreta_calificacion on libreta_calificacion.id = notas_detalle.idlibreta
						LEFT JOIN curso_ofertado on curso_ofertado.id = libreta_calificacion.idcurso
						LEFT JOIN detalle_matricula on detalle_matricula.id = notas_detalle.iddetallematricula
						
						LEFT JOIN asignatura on asignatura.idAsig = detalle_matricula.idasig
						LEFT JOIN factura on factura.id = detalle_matricula.idfactura
						LEFT JOIN informacionpersonal on informacionpersonal.CIInfPer = factura.cedula
						where factura.id = #{@factura.id} and informacionpersonal.CIInfPer = '#{@usuario.CIInfPer}') c
						GROUP by c.iddetallematricula 
						order by c.nombre";

						connection = ActiveRecord::Base.connection
						@results = connection.select_all(sqlsnna)
						#@notasalumno = select_all(sql)

						#if !@results.nil?
						#	render "snna"
						#end
				
					
			end
		end
		sqltotal = "SELECT periodolectivo.DescPerLec as período, notasalumnoasignatura.idPer, malla_carrera.idcarrera, 
				carrera.NombCarr as carrera, notasalumnoasignatura.CIInfPer as cédula,
				concat(informacionpersonal.ApellInfPer, ' ', informacionpersonal.ApellMatInfPer, ' ', 
				informacionpersonal.NombInfPer) as nombre, notasalumnoasignatura.idnaa,
				notasalumnoasignatura.idAsig, notasalumnoasignatura.CalifFinal, notasalumnoasignatura.asistencia,
				detalle_malla.peso, round(sum(notasalumnoasignatura.CalifFinal*detalle_malla.peso/100), 2) as sumaNota, 
				round(sum(notasalumnoasignatura.asistencia*detalle_malla.peso/100), 0) as sumaAsistencia,
				if( (round(sum(notasalumnoasignatura.CalifFinal*detalle_malla.peso/100), 2) >= 8 
				 and round(sum(notasalumnoasignatura.asistencia*detalle_malla.peso/100), 0) >= 70 ), 
				'APROBADO', 'REPROBADO' ) AS Estado, count(notasalumnoasignatura.idAsig) as contador
				FROM notasalumnoasignatura
                LEFT JOIN periodolectivo on periodolectivo.idper = notasalumnoasignatura.idPer
                LEFT JOIN informacionpersonal on informacionpersonal.CIInfPer = notasalumnoasignatura.CIInfPer
				LEFT JOIN detalle_matricula on detalle_matricula.id = notasalumnoasignatura.iddetalle
				LEFT JOIN curso_ofertado on curso_ofertado.id = detalle_matricula.idcurso
				LEFT JOIN detalle_malla on detalle_malla.id = curso_ofertado.iddetallemalla
				LEFT JOIN malla_carrera on malla_carrera.id = detalle_malla.idmalla
                LEFT JOIN carrera on carrera.idCarr = malla_carrera.idcarrera
				where malla_carrera.detalle like '%SNNA%'
				and notasalumnoasignatura.CIInfPer = '#{@usuario.CIInfPer}'
				GROUP BY malla_carrera.idcarrera"
		#connection = ActiveRecord::Base.connection
		#@nivelacion = connection.select_all(sqltotal)
		#if !@results.nil?
			#crear_nota_snna(@results)
		#end
					#@notasalumno = select_all(sql)
		
		
		if !@detallematricula.nil?
			@detallematricula.each do |matricula|
				
				#if (matricula.estado == 2)
				#	@estado_matricula = 0
				#	flash[:notice] = "Usted tiene valores pendientes de pago !!"
				#end
				hash = get_total_componente(matricula.id)
				if !hash.empty?
					notaF1 = (((!hash['A1'].nil?)?hash['A1']:0)*(@ca?@ca.valor/100:0) + 
								((!hash['B1'].nil?)?hash['B1']:0)*(@cb?@cb.valor/100:0) + 
								((!hash['C1'].nil?)?hash['C1']:0)*(@cc?@cc.valor/100:0))*(@ct?@ct.valor/100:0) + 
								((!hash['X1'].nil?)?hash['X1']:0)*(@ex?@ex.valor/100:0)
					notaF2 = (((!hash['A2'].nil?)?hash['A2']:0)*(@ca?@ca.valor/100:0) + 
								((!hash['B2'].nil?)?hash['B2']:0)*(@cb?@cb.valor/100:0) + 
								((!hash['C2'].nil?)?hash['C2']:0)*(@cc?@cc.valor/100:0))*(@ct?@ct.valor/100:0) + 
								((!hash['X2'].nil?)?hash['X2']:0)*(@ex?@ex.valor/100:0)
					notaRec = (!hash['R0'].nil?)?hash['R0']:0
			
					notaF1 = notaF1.round(2)
					notaF2 = notaF2.round(2)
					total = notaF1.round + notaF2.round
					hash['nota1'] = notaF1.round
					hash['nota2'] = notaF2.round
					hash['recuperacion'] = notaRec.round
					if total >= 14
						hash['notaF'] = total/2.round(2)
					elsif (total >= 10 && total < 14)
						if (total + notaRec >= 20)
							hash['notaF'] = 7.0
						else
							hash['notaF'] = total/2.round(2)
						end
					else
						hash['notaF'] = total/2.round(2)
					end
					if (!hash['T1'].nil?)
						if ( hash['T1']>= 0 && hash['T1'] <=10 )
							hash['T1'] = (hash['T1']*10).to_i.to_s + '%'
						
						elsif ( hash['T1']> 10 && hash['T1'] <=100 )
							hash['T1'] = (hash['T1']).to_i.to_s + '%'
						end
					end
					if (!hash['T2'].nil?)
						if ( hash['T2']>= 0 && hash['T2'] <=10 )
							hash['T2'] = (hash['T2']*10).to_i.to_s + '%'
				
						elsif ( hash['T2'] > 10 && hash['T2'] <=100 )
							hash['T2'] = (hash['T2']).to_i.to_s + '%'
						end
					end
				end
				asignatura = matricula.asignatura.NombAsig
				@notas_componente.merge!({asignatura=>hash})
				#@notas_componente1.merge!(get_total_componente(matricula.id))
				
			end
			

		end
		
	end

	def crear_nota
		#set_periodo
		cedula = params[:id]
		idper = params[:idper]
		if !idper.nil?
			sql = 'select y.idper, y.cedula, y.estudiante, y.iddetallematricula, y.idasignatura, y.idcurso,
		y.nota1, y.nota2, y.asistencia, y.R, y.N, y.M, y.NT, 
        if( (y.nota1 + y.nota2)>= 14, round((y.nota1 + y.nota2)/2, 2), 
           if( (y.nota1 + y.nota2 + y.R)>= 20 ,7.00, round((y.nota1 + y.nota2)/2, 2) ) 
        ) as final,
        if( y.N > y.M, round(y.N, 2), round(y.M, 2) ) as notasnna
        
from (
select x.idper, x.cedula, x.estudiante, x.iddetallematricula, x.idasignatura, x.idcurso,
	sum(x.CompA1) as A1, sum(x.CompB1) as B1, sum(x.CompC1) as C1, sum(x.CompX1) as X1,
    sum(x.CompT1) as T1,
    sum(x.CompA2) as A2, sum(x.CompB2) as B2, sum(x.CompC2) as C2, sum(x.CompX2) as X2,
    sum(x.CompT2) as T2, sum(x.CompR) as R,
    sum(x.CompN) as N, sum(x.CompM) as M, sum(x.CompNT) as NT, 
    CAST(sum(x.CompA1) + sum(x.CompB1) + sum(x.CompC1) + sum(x.CompX1) AS UNSIGNED) as nota1,
    CAST(sum(x.CompA2) + sum(x.CompB2) + sum(x.CompC2) + sum(x.CompX2) AS UNSIGNED ) as nota2,
    CAST((sum(x.CompT1) + sum(x.CompT2))/2 *10  AS UNSIGNED ) as asistencia
    
    
	from (
select u.idper, u.estudiante, u.cedula, u.iddetallematricula, u.idasignatura,
        u.sigla, u.hemisemestre, u.nota, u.promedio, 	u.contador, u.peso, u.idcurso,
    IF(u.hemisemestre = 1 && sigla = "A", u.promedio*u.peso,0) AS CompA1,
    IF(u.hemisemestre = 1 && sigla = "B", u.promedio*u.peso,0) AS CompB1,
    IF(u.hemisemestre = 1 && sigla = "C", u.promedio*u.peso,0) AS CompC1,
    IF(u.hemisemestre = 1 && sigla = "X", u.promedio*u.peso,0) AS CompX1,
    IF(u.hemisemestre = 1 && sigla = "T", u.promedio*u.peso,0) AS CompT1,
    IF(u.hemisemestre = 2 && sigla = "A", u.promedio*u.peso,0) AS CompA2,
    IF(u.hemisemestre = 2 && sigla = "B", u.promedio*u.peso,0) AS CompB2,
    IF(u.hemisemestre = 2 && sigla = "C", u.promedio*u.peso,0) AS CompC2,
    IF(u.hemisemestre = 2 && sigla = "X", u.promedio*u.peso,0) AS CompX2,
    IF(u.hemisemestre = 2 && sigla = "T", u.promedio*u.peso,0) AS CompT2,
    IF(u.hemisemestre = 0 && sigla = "R", u.promedio*u.peso,0) AS CompR,
    IF(u.hemisemestre = 0 && sigla = "N", u.promedio*u.peso,0) AS CompN,
    IF(u.hemisemestre = 0 && sigla = "M", u.promedio*u.peso,0) AS CompM,
    IF(u.hemisemestre = 0 && sigla = "T", u.promedio*u.peso,0) AS CompNT    
	
from (

select notas_detalle.iddetallematricula, factura.cedula, parametroscalificacion.sigla,
    detalle_malla.idasignatura, libreta_calificacion.hemisemestre, notas_detalle.nota, cast(sum(nota)/count(nota) as UNSIGNED) as promedio, count(nota) as contador, factura.idper, detalle_matricula.idcurso,
	notas_detalle.peso, concat(ApellInfPer, " ", ApellMatInfPer, " ", NombInfPer) as estudiante
	
FROM notas_detalle
LEFT JOIN libreta_calificacion on libreta_calificacion.id = notas_detalle.idlibreta
LEFT JOIN componentescalificacion on componentescalificacion.idcomponente = libreta_calificacion.idcomponente
LEFT JOIN parametroscalificacion on parametroscalificacion.idparametro = componentescalificacion.idparametro
LEFT JOIN curso_ofertado on curso_ofertado.id = libreta_calificacion.idcurso
LEFT JOIN detalle_malla on detalle_malla.id = curso_ofertado.iddetallemalla    
LEFT JOIN detalle_matricula on detalle_matricula.id = notas_detalle.iddetallematricula
#LEFT JOIN asignatura on asignatura.idAsig = detalle_matricula.idasig
LEFT JOIN factura on factura.id = detalle_matricula.idfactura
LEFT JOIN informacionpersonal on informacionpersonal.CIInfPer = factura.cedula
where factura.tipo_documento = "MATRICULA"  
AND detalle_matricula.estado = 1
AND informacionpersonal.CIInfPer = ' + '"' + cedula + '"' + ' and factura.idper = ' + idper.to_s + 

' GROUP by notas_detalle.iddetallematricula, libreta_calificacion.hemisemestre, parametroscalificacion.sigla
ORDER BY notas_detalle.iddetallematricula, libreta_calificacion.hemisemestre, libreta_calificacion.idcomponente ) u
group by u.iddetallematricula, u.hemisemestre, u.sigla
ORDER BY u.iddetallematricula, u.hemisemestre, u.sigla ) x
GROUP by x.iddetallematricula ) y'
			connection = ActiveRecord::Base.connection
			@resultados = connection.select_all(sql)
			if !@resultados.nil?
				@resultados.each do |res|
					notasalumnoasignatura = Notasalumnoasignatura.where("iddetalle = ?",
								res['iddetallematricula']).first()
						
					if !notasalumnoasignatura.nil?
						asistencia = res['asistencia'].to_f.round() unless res['asistencia'].nil?
						aprobada = (res['final'] >= 7.00 and res['asistencia'] >= 70 ) ? 1 : 0 unless 
							(res['final'].nil? and res['asistencia'].nil?)
						estado = (res['final'] >= 7.00 and res['asistencia'] >= 70 ) ? 'APROBADA' : 'REPROBADA' unless 
							(res['final'].nil? and res['asistencia'].nil?)
						notasalumnoasignatura.CalifFinal = res['final'] unless res['final'].nil?
						notasalumnoasignatura.asistencia = asistencia
						notasalumnoasignatura.observacion = estado
						notasalumnoasignatura.aprobada = aprobada
						grabo = notasalumnoasignatura.save
						
					else
						asistencia = res['asistencia'].to_f.round() unless res['asistencia'].nil?
						aprobada = (res['final'] >= 7.00 and res['asistencia'] >= 70 ) ? 1 : 0 unless 
							(res['final'].nil? and res['asistencia'].nil?)
						estado = (res['final'] >= 7.00 and res['asistencia'] >= 70 ) ? 'APROBADA' : 'REPROBADA' unless 
							(res['final'].nil? and res['asistencia'].nil?)
						notasalumnoasignatura = Notasalumnoasignatura.new
						notasalumnoasignatura.idPer = res['idper'] unless res['idper'].nil?
						notasalumnoasignatura.CIInfPer = res['cedula'] unless res['cedula'].nil?
						notasalumnoasignatura.idAsig = res['idasignatura'] unless res['idasignatura'].nil?
						notasalumnoasignatura.iddetalle = res['iddetallematricula'] unless res['iddetallematricula'].nil?
						notasalumnoasignatura.CalifFinal = res['final'] unless res['final'].nil?
						notasalumnoasignatura.asistencia = asistencia
						notasalumnoasignatura.observacion = estado
						notasalumnoasignatura.aprobada = aprobada
						notasalumnoasignatura.StatusCalif = 3;
						notasalumnoasignatura.VRepite = 1;
						notasalumnoasignatura.registro = Date.today.to_time
						notasalumnoasignatura.convalidacion = 0;
						grabo = notasalumnoasignatura.save	
						
						

					end
				end			
					#printr
							#echo var_dump($modelnota->errors); exit;
						
				
				#$end_time = microtime(true);			
				#$execution_time = ($end_time - $start_time)/60;			
				#echo var_dump($execution_time); exit;
			end	
			redirect_to ver_notas_path(cedula)
		end

	end

	def search
		
		if params[:periodo] 
			
			@idperiodo = params[:periodo]
			#@nivel = params[:nivel]
			#@cedula = params[:CIInfPer]
			#@paralelo = params[:paralelo]
			#@malla_estudiante = Mallaestudiante.where({cedula: @cedula, carrera: @idcarrera}).first()
			@idperiodo = Periodolectivo.where("idper = ?", @idperiodo).first()
			#@malla_estudiante = Ingreso.where({CIInfPer: @usuario, idcarr: @idcarrera}).order("idper DESC").first()
			#redirect_to action: 'index'
		end
		#return malla_estudiante
		#redirect_to action: 'index'
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_periodo
		@periodo = Periodolectivo.where("StatusPerLec = ?", 1).first()
	end
	def set_configuracion
		@ca = Configuracion.where("dato = ?", 'CA').first()
		@cb = Configuracion.where("dato = ?", 'CB').first()
		@cc = Configuracion.where("dato = ?", 'CC').first()
		@ct = Configuracion.where("dato = ?", 'CT').first()
		@ex = Configuracion.where("dato = ?", 'EX').first()
		@as = Configuracion.where("dato = ?", 'AS').first()

	end
		
	def evaluo_docente(cedula, periodo)
		#fecha = Date.parse '2018-03-14'
		sql = 'select count(*)     
			from (
			SELECT  detalle_matricula.idasig 
			FROM     siad.detalle_matricula, siad.factura, siad.curso_ofertado                        
			where     factura.id=detalle_matricula.idfactura
					and curso_ofertado.id=detalle_matricula.idcurso                      
					and factura.tipo_documento="MATRICULA"
					and factura.idper = ' + periodo.to_s +
					' and curso_ofertado.fecha_fin<= "2018-03-14" ' +
					' and factura.cedula= ' + '"' + cedula + '"' + 
					' and length(curso_ofertado.iddocente)>0
					and detalle_matricula.estado = 1
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

	def get_suma_componente(notas, mat, hemi, comp)
		sum = 0
		cont = 1
		total = 0
		notas.each do |nota|
			if nota.iddetallematricula == mat && nota.libretacalificacion.hemisemestre == hemi && 
					nota.libretacalificacion.componentecalificacion.parametrocalificacion.sigla == comp
				notaest = if nota.nota then nota.nota else 0 end
				sum = sum + notaest
				total = sum/cont
				cont = cont + 1			
			end
		end
		return total
	end


	def crear_nota_snna(resultados)
		#resultados = params[:notas]
		resultados.each do |res|
				notasalumnoasignatura = Notasalumnoasignatura.where("iddetalle = ? ",
							res['iddetallematricula']).first()	
				if !notasalumnoasignatura.nil?
					asistencia = res['NAT'].to_f.round()*10 unless res['NAT'].nil?
					aprobada = (res['Estado'] == 'APROBADA') ? 1 : 0 unless res['Estado'].nil?
					notasalumnoasignatura.CalifFinal = res['notafinal'].to_f.round() unless res['notafinal'].nil?
					notasalumnoasignatura.asistencia = asistencia
					notasalumnoasignatura.observacion = res['Estado'] unless res['Estado'].nil?
					notasalumnoasignatura.aprobada = aprobada
					grabo = notasalumnoasignatura.save
				else
					asistencia = res['NAT'].to_f.round()*10 unless res['NAT'].nil?
					aprobada = (res['Estado'] == 'APROBADA') ? 1 : 0 unless res['Estado'].nil?
					notasalumnoasignatura = Notasalumnoasignatura.new
					notasalumnoasignatura.idPer = res['idper'] unless res['idper'].nil?
					notasalumnoasignatura.CIInfPer = res['cedula'] unless res['cedula'].nil?
					notasalumnoasignatura.idAsig = res['idAsig'] unless res['idAsig'].nil?
					notasalumnoasignatura.iddetalle = res['iddetallematricula'] unless res['iddetallematricula'].nil?
					notasalumnoasignatura.CalifFinal = res['notafinal'].to_f.round() unless res['notafinal'].nil?
					notasalumnoasignatura.asistencia = asistencia
					notasalumnoasignatura.observacion = res['Estado'] unless res['Estado'].nil?
					notasalumnoasignatura.aprobada = aprobada
					notasalumnoasignatura.StatusCalif = 3;
					notasalumnoasignatura.VRepite = 1;
					notasalumnoasignatura.registro = Date.today.to_time
					notasalumnoasignatura.convalidacion = 0;
					grabo = notasalumnoasignatura.save	
					#printr	

				end			
				#printr
						#echo var_dump($modelnota->errors); exit;
					
			
			#$end_time = microtime(true);			
			#$execution_time = ($end_time - $start_time)/60;			
			#echo var_dump($execution_time); exit;		
		end


	end

	
	def get_total_componente(idmatricula)
		notacomp = 0
		hemi = 0
		comp = ''
		key = {}
		hash_total = {}
		notasdetalle = Notasdetalle.joins(libretacalificacion: :componentecalificacion)
						.select("idnota, iddetallematricula, idlibreta, 
							libreta_calificacion.idparametro as param, nota, sum(nota)/count(idnota) as promedio")
						.where("iddetallematricula = ?", idmatricula)
						.order("libreta_calificacion.hemisemestre ASC, libreta_calificacion.idparametro ASC")
						.group("idcurso, iddetallematricula, libreta_calificacion.hemisemestre,
							componentescalificacion.idparametro")
						.all()
		if !notasdetalle.nil?
			notasdetalle.each do |nota|
				idmatricula = nota.iddetallematricula
				hemi = nota.libretacalificacion.hemisemestre
				comp = nota.libretacalificacion.componentecalificacion.parametrocalificacion.sigla
				notacomp = if !nota.promedio.nil? then nota.promedio.round else 0 end
				key = {'matricula'=>idmatricula, ('hemi' + hemi.to_s)=>hemi, (comp.to_s + hemi.to_s)=>notacomp}
				hash_total.merge!(key)
			end
		end
		return hash_total
		
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def detallematricula_params
		#params.require(:notasalumnoasignatura).permit(:id, :idfactura, :idasig, :idper)
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

end
