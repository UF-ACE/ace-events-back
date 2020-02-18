require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let! (:event) do
    create(:event)
  end

  let (:user) do
    create(:user)
  end

  let (:chair) do
    create(:chair)
  end

  let (:user_session) do
    { user_id: user.id }
  end

  let (:chair_session) do
    { user_id: chair.id }
  end

  let (:valid_params) do
    attributes_for(:event)
  end

  let (:invalid_params) do
    attributes_for(:event, name: nil)
  end

  describe "GET index" do
    before do
      get :index, { format: :json }
    end

    it 'assigns all events to @events' do
      expect(assigns[:events]).to eq([event])
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: event.id, format: :json }
    end

    it 'assigns event to @event' do
      expect(assigns[:event]).to eq(event)
    end

    it 'returns HTTP status 200 (OK)' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    context 'as chair or eboard' do
      context 'with valid parameters' do
        it 'creates a new event' do
          expect do
            post :create, params: { event: valid_params }, session: chair_session
          end.to change(Event, :count).by(1)
        end

        it 'returns HTTP status 201 (Created)' do
          post :create, params: { event: valid_params }, session: chair_session
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          post :create, params: { event: invalid_params }, session: chair_session
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'as a normal member' do
      it 'returns HTTP status 403 (Forbidden)' do
        post :create, params: { event: valid_params }, session: user_session
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'while logged out' do
      it 'returns HTTP status 403 (Forbidden)' do
        post :create, session: { event: valid_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "PUT update" do
    context 'as a chair or eboard' do
      context 'with valid parameters' do
        before do
          put :update, params: {id: event.id, event: valid_params}, session: chair_session
        end

        it 'returns HTTP status 200 (OK)' do
          expect(response).to have_http_status(:ok)
        end

        it 'updates the requested event name' do
          event.reload
          expect(event.name).to eq(valid_params[:name])
        end

        it 'updates the requested event description' do
          event.reload
          expect(event.description).to eq(valid_params[:description])
        end

        it 'updates the requested event short description' do
          event.reload
          expect(event.short_description).to eq(valid_params[:short_description])
        end

        it 'updates the requested event location' do
          event.reload
          expect(event.location).to eq(valid_params[:location])
        end

        it 'updates the requested event start time' do
          event.reload
          expect(event.start_time).to eq(valid_params[:start_time])
        end

        it 'updates the requested event end time' do
          event.reload
          expect(event.end_time).to eq(valid_params[:end_time])
        end

        it 'cannot update a requested sign in id' do
          event.reload
          expect(event.sign_in_id).to_not eq(valid_params[:sign_in_id])
        end
      end

      context 'with invalid parameters' do
        it 'returns HTTP status 400 (Bad Request)' do
          put :update, params: {id: event.id, event: invalid_params}, session: chair_session
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with an invalid event' do
        it 'returns HTTP status 404 (Not Found)' do
          put :update, params: {id: -1, event: valid_params}, session: chair_session
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'as a normal member' do
      it 'returns HTTP status 403 (Forbidden)' do
        put :update, params: {id: event.id, event: valid_params}, session: user_session
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when logged out' do
      it 'returns HTTP status 403 (Forbidden)' do
        put :update, params: {id: event.id, event: valid_params}
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE destroy" do
    context 'with an invalid event' do
      it 'returns HTTP status 404 (Not Found)' do
        delete :destroy, params: {id: -1}, session: chair_session
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a valid event' do
      context 'as a chair or eboard' do
        it 'returns HTTP status 200 (OK)' do
          delete :destroy, params: {id: event.id}, session: chair_session
          expect(response).to have_http_status(:ok)
        end

        it 'deletes the requested event' do
          expect { delete :destroy, params: {id: event.id}, session: chair_session }.to change(Event, :count).by(-1)
        end
      end

      context 'as a normal member' do
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: {id: event.id}, session: user_session
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when logged out' do
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: {id: event.id}
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
