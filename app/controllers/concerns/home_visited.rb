# frozen_string_literal: true

# Module for counting home visits
module HomeVisited
  def update_times_visited
    session[:counter] ||= 0
    session[:counter] += 1
  end

  def times_visited
    session[:counter] || 0
  end
end
