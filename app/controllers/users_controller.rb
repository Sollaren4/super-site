class UsersController < ApplicationController
  before_action :set_user, only: %i[update destroy edit]

  def new
    @user = User.new
  end

  def create
    @user  = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Регистрация прошла успешно!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации'

      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Данные пользователя обновлены'
    else
      flash.now[:alert] = 'При попытке сохранить пользователя возникли ошибки'

      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
