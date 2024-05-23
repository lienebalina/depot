module HomeSession

  before_action :update_times_visited, only: [:index]

  def update_times_visited
    session[:counter] ||= 0
    session[:counter] += 1
  end

  def times_visited
    session[:counter] || 0
  end
end
