require "rails_helper"

describe "/users" do
  let(:valid_params) {
    {
      nickname: "john_doe",
    }
  }

  let(:invalid_params) {
    {
      nickname: "",
    }
  }

  describe "GET /index" do
    it "returns a successful response" do
      get users_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      user = create(:user)
      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new record" do
        expect {
          post users_path, params: { user: valid_params }
        }.to change(User, :count).by(1)
      end

      it "returns a successful response status" do
        post users_path, params: { user: valid_params }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not create a new record" do
        expect {
          post users_path, params: { user: invalid_params }
        }.not_to change(User, :count)
      end

      it "returns an error response status" do
        post users_path, params: { user: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) {
        valid_params.merge(nickname: "updated_nickname")
      }

      it "updates the requested record" do
        user = create(:user)
        patch user_path(user), params: { user: new_params }
        user.reload
        expect(user.nickname).to eq(new_params[:nickname])
      end

      it "returns a successful status" do
        user = create(:user)
        patch user_path(user), params: { user: new_params }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        user = create(:user)
        patch user_path(user), params: { user: invalid_params }
        user.reload
        expect(user.nickname).not_to eq(invalid_params[:nickname])
      end

      it "returns an error response status" do
        user = create(:user)
        patch user_path(user), params: { user: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
