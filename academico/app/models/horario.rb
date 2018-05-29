class Horario < ApplicationRecord
	self.table_name = "horario"
	belongs_to :periodolectivo, :foreign_key => "idper", optional: true
	belongs_to :carrera, :foreign_key => "idcarrera", optional: true
	#attr_accessor :{LoginUsu, ClaveUsu}
	#has_secure_password
end
