class Componentecalificacion < ApplicationRecord
	self.table_name = "componentescalificacion"
	belongs_to :parametrocalificacion, :foreign_key => "idparametro", optional: true
	#attr_accessor :{LoginUsu, ClaveUsu}
	#has_secure_password
end
