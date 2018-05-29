class Event < ApplicationRecord
	self.table_name = "detalle_horario"
	belongs_to :cursoofertado, :foreign_key => "idcurso", optional: true
end
