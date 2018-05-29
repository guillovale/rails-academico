class Notasdetalle < ApplicationRecord
	
	self.table_name = "notas_detalle"
	belongs_to :libretacalificacion, :foreign_key => "idlibreta", optional: true
	belongs_to :detallematricula, 	:foreign_key => "iddetallematricula", optional: true

	#self.primary_key = "idnaa"
end
