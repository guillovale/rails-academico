class Cursoofertado < ApplicationRecord
	self.table_name = "curso_ofertado"
	belongs_to :detallemalla, foreign_key: "iddetallemalla", optional: true
end
