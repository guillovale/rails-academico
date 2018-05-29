class Notasalumnoasignatura < ApplicationRecord
	
	self.table_name = "notasalumnoasignatura"
	belongs_to :periodolectivo, :foreign_key => "idPer", optional: true
	belongs_to :matricula, 
		:foreign_key => "idMatricula", optional: true
	belongs_to :asignatura, 
		:foreign_key => "idAsig", optional: true
	belongs_to :detallematricula, 
		:foreign_key => "iddetalle", optional: true
	self.primary_key = "idnaa"
end
