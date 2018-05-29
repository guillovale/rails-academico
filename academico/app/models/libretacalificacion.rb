class Libretacalificacion < ApplicationRecord
	
	self.table_name = "libreta_calificacion"
	belongs_to :periodolectivo, :foreign_key => "idper", optional: true
	belongs_to :parametrocalificacion, :foreign_key => "idparametro", optional: true
	belongs_to :componentecalificacion, :foreign_key => "idcomponente", optional: true
end
