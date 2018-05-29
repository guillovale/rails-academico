class Detalleparalelo < ApplicationRecord
	self.table_name = "detalleparalelo"
	belongs_to :periodolectivo, :foreign_key => "idPer", optional: true
	belongs_to :paralelo, :foreign_key => "idparalelo", optional: true
	belongs_to :carrera, optional: true
end
