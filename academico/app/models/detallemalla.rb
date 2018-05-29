class Detallemalla < ApplicationRecord
	self.table_name = "detalle_malla"
	belongs_to :mallacarrera, :foreign_key => "idmalla", optional: true
	belongs_to :asignatura, :foreign_key => "idasignatura", optional: true
end
