class UsersController < ApplicationController
  def index
    # render plain: "I'm in the index action!"
    render json: User.all
  end

  def create
    # render json: params
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
      # 422 is the status code for an unprocessable entity.
      # You can either pass the status code or status symbol.
      # In other words, you could also return:
      # render json: user.errors.full_messages, status: 422
    end
  end

  def show
    # render json: params
    render json: User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
