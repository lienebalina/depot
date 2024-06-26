# frozen_string_literal: true

# Visit counter module
module VisitCounter
  def update_times_visited
    session[:counter] ||= 0
    session[:counter] += 1
  end

  def times_visited
    session[:counter] || 0
  end
end
