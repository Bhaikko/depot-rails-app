class ApplicationController < ActionController::Base
  include Timer
  include SessionHandler

  around_action :attach_time_in_header
  
  before_action :update_hit_counter, only: [:index, :show, :edit, :new]
  before_action :authorize
  before_action :logout_if_inactive, if: :user_session_exists?
  before_action :attach_ip_in_header

  protected def authorize
    unless current_user
      redirect_to login_url, alert: "Please log in before proceeding."
    end
  end

  protected def current_user
    @logged_in_user ||= User.find_by(id: session[:user_id])
  end

  protected def authorize_admin
    unless current_user.admin?
      redirect_to store_index_path, notice: "You don't have privilege to access this section"
    end
  end

  protected def update_hit_counter
    if user = User.find_by(id: session[:user_id])
      user.hit_count.increment!(:count)
      @user_hit_count = user.hit_count.count
    end

    @total_hit_count = HitCount.total_hit_count
  end

  protected def attach_time_in_header
    start_timer
    yield
    response.header['X-Responded-In'] = time_elapsed_in_milliseconds
  end

  protected def attach_ip_in_header
    @client_ip = request.ip
  end

  protected def logout_if_inactive
    if Time.current - session[:last_request_time].to_time >= 300
      logout
    else
      session[:last_request_time] = Time.current
    end
  end
end
