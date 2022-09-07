module SessionHandler
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def auto_session_timeout(inactivity_time)
      # before_action:
      define_method('auto_session_timeout') do
        if user_session_exists? && Time.current - session[:last_request_time].to_time >= inactivity_time
          logout
        else
          session[:last_request_time] = Time.current
        end
      end
    end
  end

  def user_session_exists?
    session[:user_id].present?
  end

  def logout
    reset_session
    redirect_to store_index_url, notice: "Logged out"
  end
end
