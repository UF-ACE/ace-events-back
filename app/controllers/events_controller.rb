class EventsController < ApplicationController
  authorize_resource

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(id: params[:id])
    return head :not_found unless @event
  end

  def create
    return head :forbidden unless can? :create, Event
    event = Event.new(event_create_params)
    return head :created, location: event_path(event) if event.save
    render json: {error: event.errors}, status: :bad_request
  end

  def update
    event = Event.find_by(id: params[:id])
    return head :not_found unless event
    return head :forbidden unless can? :update, Event
    return head :ok if event.update(event_update_params)
    render json: {error: event.errors}, status: :bad_request
  end

  def destroy
    event = Event.find_by(id: params[:id])
    return head :not_found unless event
    return head :forbidden unless can? :destroy, Event
    event.destroy
    return head :ok
  end

  private

  def event_create_params
    parameters = params.require(:event).permit(:name, :description, :location, :start_time, :end_time)
    parameters[:sign_in_id] = Event.gen_sign_in_id()
    parameters
  end

  def event_update_params
    params.require(:event).permit(:name, :description, :location, :start_time, :end_time)
  end
end
