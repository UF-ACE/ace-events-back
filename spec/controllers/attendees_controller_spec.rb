require 'rails_helper'

RSpec.describe AttendeesController, type: :controller do

  let (:user) do
    create(:user)
  end

  let (:different_user) do
    create(:user)
  end

  let (:chair) do
    create(:chair)
  end

  let (:event) do
    create(:event)
  end

  let! (:attendee) do
    create(:attendee, event: event, user: different_user)
  end

  let (:logged_in) do
    { user_id: user.id }
  end

  let (:logged_in_diff) do
    { user_id: different_user.id }
  end

  let (:chair_session) do
    { user_id: chair.id }
  end

  let (:valid_params) do
    { user_id: user.id }
  end

  let (:invalid_params) do
    { user_id: nil }
  end

  describe "GET index" do
    before do
      get :index, params: { event_id: event.id, format: :json }
    end

    it 'assigns all attendees to @attendees' do
      expect(assigns[:attendees]).to eq([attendee])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    context 'while logged in' do
      context 'with valid parameters' do
        it 'creates a new attendee' do
          expect do
            post :create, params: { id: event.sign_in_id }, session: logged_in
          end.to change(Attendee, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :create, params: { id: event.sign_in_id }, session: logged_in
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :create, params: { id: -1 }, session: logged_in
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'while logged out' do
      it 'returns HTTP status 403 (Forbidden)' do
        post :create, params: { id: event.sign_in_id }, session: { attendee: valid_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE destroy" do
    context 'with an invalid attendee' do
      it 'returns HTTP status 404 (Not Found)' do
        delete :destroy, params: {event_id: event.id, id: -1}, session: logged_in
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a valid attendee' do
      context 'as the attendee' do
        it 'returns HTTP status 200 (OK)' do
          delete :destroy, params: { event_id: attendee.event.id, id: attendee.id }, session: logged_in_diff
          expect(response).to have_http_status(:ok)
        end

        it 'deletes the requested attendee' do
          expect { delete :destroy, params: { event_id: attendee.event.id, id: attendee.id}, session: logged_in_diff }.to change(Attendee, :count).by(-1)
        end
      end

      context 'as a chair or eboard' do
        it 'returns HTTP status 200 (OK)' do
          delete :destroy, params: { event_id: attendee.event.id, id: attendee.id}, session: chair_session
          expect(response).to have_http_status(:ok)
        end

        it 'deletes the requested attendee' do
          expect { delete :destroy, params: { event_id: attendee.event.id, id: attendee.id}, session: chair_session }.to change(Attendee, :count).by(-1)
        end
      end

      context 'not as the requested attendee' do
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: { event_id: attendee.event.id, id: attendee.id}, session: logged_in
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when logged out' do
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: { event_id: attendee.event.id, id: attendee.id}
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
