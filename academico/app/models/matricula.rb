class Matricula < ApplicationRecord
	self.table_name = "matricula"
	belongs_to :periodolectivo, :foreign_key => "idPer", optional: true
	belongs_to :carrera, optional: true
end
