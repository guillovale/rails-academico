class Detallematricula < ApplicationRecord
	self.table_name = "detalle_matricula"
	belongs_to :factura, :foreign_key => "idfactura", optional: true
	belongs_to :asignatura, 
		:foreign_key => "idasig", optional: true
end
