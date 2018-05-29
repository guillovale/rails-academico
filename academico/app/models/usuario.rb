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
	#validates :Telf1InfPer, presence: true
	validates :CelularInfPer, presence: true
	validates :mailPer, presence: true
	#def initialize(params = {})
  	#	file = params.delete(:fotografia)
	 # super
	  #if file
	   # self.fotografia = file.read
	  #end
	#end


end
