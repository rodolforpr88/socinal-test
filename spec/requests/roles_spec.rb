require "rails_helper"

describe "/roles" do
  let(:valid_params) {
    {
      name: "user.edit"
    }
  }

  let(:invalid_params) {
    {
      name: ""
    }
  }

  let(:user) { create(:user) }

  describe "GET /show" do
    it "returns a successful response" do
      get user_role_path(user)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) {
        { name: "user.destroy" }
      }

      it "updates the requested record" do
        patch user_role_path(user), params: { role: new_params }
        user.role.reload
        expect(user.role.name).to eq(new_params[:name])
      end

      it "returns a successful status" do
        patch user_role_path(user), params: { role: new_params }
        user.role.reload
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        patch user_role_path(user), params: { role: invalid_params }
        user.role.reload
        expect(user.role.name).not_to eq(invalid_params[:name])
      end

      it "returns an error response status" do
        patch user_role_path(user), params: { role: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
