class Mallacarrera < ApplicationRecord
	self.table_name = "malla_carrera"
	belongs_to :carrera, :foreign_key => "idCarr", optional: true

end
