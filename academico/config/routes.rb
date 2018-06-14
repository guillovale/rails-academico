Rails.application.routes.draw do
 	#get 'detallematricula/index'
	get '/detallematricula/index/:CIInfPer', to: 'detallematricula#index', as:  'ver_notas_matricula'
	post '/detallematricula/crear_nota/:CIInfPer', to: 'detallematricula#crear_nota', as:  'crear_nota'
	#post  '/detallematricula/:CIInfPer', to: 'detallematricula#search', as:  'buscar_carrera'
  #resources :notasalumnoasignaturas
	resources :events
	get '/events/index/:CIInfPer', to: 'events#index', as:  'ver_horario'
  #get 'sessions/new'
	resources :sessions
	get '/login', to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	
	get '/usuarios/show_image', to: 'usuarios#show_image'
	#post '/usuarios/:id',  to: 'usuarios#edit'

	resources :usuarios
	get '/usuarios/update_password/:id', to: 'usuarios#update_password', as:  'reset_password'
	post '/usuarios/update_password/:id', to: 'usuarios#update_password', as:  'set_password'
	#get 'usuarios/show'
	 #get 'usuarios/update_password/:CIInfPer', to: 'usuarios/update_password', as: 'reset_password'
	
	#resource :user, only: [:edit] do
	 # collection do
	#	patch 'update_password'
	#  end
	#end

	get 'static_pages/home'

  # get 'static_pages/help'
	get  '/help',    to: 'static_pages#help'

	# get 'static_pages/help'
	get '/notasalumnoasignaturas/show/:CIInfPer/:factura', to: 'notasalumnoasignaturas#show', as:  'ver_matricula'
	get '/notasalumnoasignaturas/show_notas/:CIInfPer', to: 'notasalumnoasignaturas#show_notas', as:  'ver_notas'
	get '/notasalumnoasignaturas/ver_snna/:CIInfPer', to: 'notasalumnoasignaturas#ver_snna', as:  'ver_snna'
	get  '/notasalumnoasignaturas/:CIInfPer', to: 'notasalumnoasignaturas#index', as:  'ver_malla'
	get  '/notasalumnoasignaturas/crear_matricula/:CIInfPer', to: 'notasalumnoasignaturas#crear_matricula', as:  'crear_matricula'
	
	post  '/notasalumnoasignaturas/:CIInfPer', to: 'notasalumnoasignaturas#search', as:  'buscar'
	post  '/notasalumnoasignaturas/agrega_asignatura/:CIInfPer', to: 'notasalumnoasignaturas#agrega_asignatura', as:  'agrega_asignatura'
	delete  '/notasalumnoasignaturas/:CIInfPer/:id', to: 'notasalumnoasignaturas#quitar_asignatura', as:  'quitar_asignatura'
	#resources :notasalumnoasignaturas

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'static_pages#home'
end
