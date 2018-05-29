class Detallehorario < ApplicationRecord
	self.table_name = "detalle_horario"
	belongs_to :horario, :foreign_key => "idhorario", optional: true
end
