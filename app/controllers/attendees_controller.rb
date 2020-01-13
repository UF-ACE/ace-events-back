class AttendeesController < ApplicationController
  authorize_resource

  def index
    @attendees = Attendee.where(event_id: params[:event_id])
  end

  def create
    return head :forbidden unless can? :create, Attendee
    attendee = Attendee.new(create_params)
    return head :created if attendee.save
    render json: {error: attendee.errors}, status: :bad_request
  end

  def destroy
    attendee = Attendee.find_by(event_id: params[:id], id: params[:id])
    return head :not_found if attendee.nil?
    return head :forbidden unless can? :destroy, attendee
    attendee.destroy
    head :ok
  end

  private

  def create_params
    parameters = params.require(:attendee).permit(:user_id)
    parameters[:event_id] = params[:event_id]
    parameters
  end
end
