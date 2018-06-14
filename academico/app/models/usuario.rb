class Usuario < ApplicationRecord
	self.table_name = "informacionpersonal"
	#attr_accessor :{LoginUsu, ClaveUsu}
	#has_secure_password
	validates :NombInfPer,  presence: true, length: { maximum: 45}
	#validates :GeneroPer, presence: true, length: { maximum: 1}
	#validates :EtniaPer, presence: true
	#validates :FechNacimPer, presence: true
	#validates :NacionalidadPer, presence: true
	#validates :CiudadPer, presence: true
	#validates :DirecDomicilioPer, presence: true
	#validates :current_password, confirmation: true
	validates :CelularInfPer, presence: true
	validates :codigo_dactilar, confirmation: true
	validates :codigo_dactilar_confirmation, presence: true
	#def initialize(params = {})
  	#	file = params.delete(:fotografia)
	 # super
	  #if file
	   # self.fotografia = file.read
	  #end
	#end


end
