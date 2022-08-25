module SessionHandler
  def user_session_exists?
    session[:user_id].present?
  end

  def logout
    reset_session
    redirect_to store_index_url, notice: "Logged out"
  end
end