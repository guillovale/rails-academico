module UsuariosHelper
  # Returns the Gravatar for the given user.
	def gravatar_for(usuario, size: 80)
		if usuario.valid? && usuario.mailPer.present?
			gravatar_id = Digest::MD5::hexdigest(usuario.mailPer.downcase)
			gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
			image_tag(gravatar_url, alt: usuario.ApellInfPer, class: "gravatar")
		end
	end
end
