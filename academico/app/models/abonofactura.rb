class Abonofactura < ApplicationRecord
	self.table_name = "abono_factura"
	belongs_to :factura, :foreign_key => "idfactura", optional: true
end
