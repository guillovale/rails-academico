class Factura < ApplicationRecord
	self.table_name = "factura"
	belongs_to :periodolectivo, :foreign_key => "idper", optional: true
end
