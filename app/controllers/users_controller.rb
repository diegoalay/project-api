class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    respond_with_successful(User.index)
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      respond_with_successful(@user)
    else
      respond_with_error(@user.errors.full_messages.to_sentence)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      respond_with_successful(@user)
    else
      respond_with_error(@user.errors.full_messages.to_sentence)
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      respond_with_successful
    else
      respond_with_error(@user.errors.full_messages.to_sentence)
    end
  end

  def quantify_characters
    respond_with_successful(User.quantify_characters)
  end
  
  def duplicated_emails 
    respond_with_successful(User.duplicated_emails)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
      
      return respond_with_not_found unless @user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :mobile_phone,
        :first_name, 
        :last_name, 
        :username,
        :gender,
        :status, 
        :email,
      )
    end
end
