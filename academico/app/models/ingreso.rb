class Ingreso < ApplicationRecord
	self.table_name = "ingreso"
	belongs_to :periodolectivo, :foreign_key => "idper", optional: true
	belongs_to :mallacarrera, :foreign_key => "idmalla", optional: true

	def nombre_carrera
		carreras = Carrera.where(idCarr: self.idcarr).first
		carreras.NombCarr
	end
end
