class SessionsController < Devise::SessionsController
  respond_to :json

  # prepend_before_filter :require_no_authentication, :only => [:create ]
  # before_filter :ensure_params_exist, except: :destroy

  after_filter :set_csrf_header, only: [:new, :create]

  # skip_before_filter :verify_authenticity_token

  def create
    user = User.find_for_database_authentication(
      email: params[:user][:email]
    )
    return invalid_login_attempt unless user

    if user.valid_password?(params[:user][:password])
      sign_in user
      render json: {
        user: user,
        success: true
      }
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out
    head :no_content
  end

  def check
    if current_user
      render json: { success: true, user: current_user }
    else
      render json: { error: true }
    end
  end

  private

  protected

    def ensure_params_exist
      return unless params[:user].blank?
      render json: {
        success: false
      }, status: 422
    end

    def invalid_login_attempt
      warden.custom_failure!
      render json: {
        success: false,
        message: "Error with your login or password"
      }, status: 401
    end

    def set_csrf_header
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
end