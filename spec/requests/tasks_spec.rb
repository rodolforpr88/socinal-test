require "rails_helper"

describe "/tasks" do
  let(:user) { create(:user) }
  let(:role) { create(:role, user_id: user.id) }

  let(:valid_params) {
    {
      name: "Do something",
      role_id: role.id,
    }
  }

  let(:invalid_params) {
    {
      name: "",
      role_id: nil,
    }
  }

  describe "GET /index" do
    it "returns a successful response" do
      get tasks_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      task = create(:task)
      get task_path(task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new record" do
        expect {
          post tasks_path, params: { task: valid_params }
        }.to change(Task, :count).by(1)
      end

      it "returns a successful response status" do
        post tasks_path, params: { task: valid_params }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not create a new record" do
        expect {
          post tasks_path, params: { task: invalid_params }
        }.not_to change(Task, :count)
      end

      it "returns an error response status" do
        post tasks_path, params: { task: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) {
        valid_params.merge(name: "updated_name")
      }

      it "updates the requested record" do
        task = create(:task)
        patch task_path(task), params: { task: new_params }
        task.reload
        expect(task.name).to eq(new_params[:name])
      end

      it "returns a successful status" do
        task = create(:task)
        patch task_path(task), params: { task: new_params }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        task = create(:task)
        patch task_path(task), params: { task: invalid_params }
        task.reload
        expect(task.name).not_to eq(invalid_params[:name])
      end

      it "returns an error response status" do
        task = create(:task)
        patch task_path(task), params: { task: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
