class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:session)

    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id

      redirect_to root_path, notice: 'Вы успешно вошли!'
    else
      # now, чтобы alert выскакивал только на этой превой стр
      # иначе при переходе на другую тоже выскакивает
      flash.now[:alert] = 'Неправильный email или пароль'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Вы вышли из аккаунта'
  end
end
