class ApplicationController < ActionController::Base
	# чтоб был доступен во всех шаблонах
	helper_method :current_user

	private

	def current_user
		# не авторизированный - nil
		# первый раз - запрос в базу
		# дальше уже будет запись в переменной, запрос не понадобится
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end
end