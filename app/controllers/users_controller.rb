class UsersController < ApplicationController
  before_action :check_admin

  #Index action, photos gets listed in the order at which they were created
  def index
   @users = User.order('created_at')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if user_params[:password].blank? && @user.update_without_password(user_params)
      flash[:notice] = 'Successfully updated user!'
      redirect_to users_path
    elsif @user.update_attributes(user_params)
      flash[:notice] = 'Successfully updated user!'
      redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  #Create action ensures that submitted photo gets created if it meets the requirements
  def create
   @user = User.new(user_params)
   if @user.save
     flash[:notice] = "Successfully added new user!"
     redirect_to users_path
   else
     flash[:alert] = @user.errors.full_messages.to_sentence
     redirect_to request.referrer
   end
  end

  def new
    @user = User.new
  end

  private

  #Permitted parameters when creating a photo. This is used for security reasons.
  def user_params
   params.require(:user).permit(:name, :phone, :email, :user_role_id, :password)
  end

end
