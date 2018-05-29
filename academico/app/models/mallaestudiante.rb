class Mallaestudiante < ApplicationRecord
	self.table_name = "malla_estudiante"
	#attr_accessor :{anio_habilitacion}
	#has_secure_password


	def nombre_carrera
		carreras = Carrera.where(idCarr: self.carrera).first
		carreras.NombCarr
	end
end
