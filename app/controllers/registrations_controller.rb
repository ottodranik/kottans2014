class RegistrationsController < Devise::RegistrationsController
  # skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      sign_in user
      render(
        json: Jbuilder.encode do |j|
          j.success true
          j.email user.email
        end,
        status: 201
      )
      return
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :encrypted_password)
  end

end
