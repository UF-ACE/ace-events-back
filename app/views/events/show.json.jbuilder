if session[:user_id].present? && User.find_by(id: session[:user_id]).chair?
  json.content @event
else
  json.content @event, :id, :name, :description, :location, :start_time, :end_time
end