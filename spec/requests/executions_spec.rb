require "rails_helper"

describe "/executions" do
  let(:user) { create(:user) }
  let(:role) { create(:role, user_id: user.id) }
  let(:task) { create(:task, role_id: role.id) }
  let!(:execution) { create(:execution, user_id: user.id, task_id: task.id) }

  let(:valid_params) { { execution: { user_id: user.id } } }
  let(:invalid_params) { { execution: { user_id: 0 } } }

  describe "GET /index" do
    it "returns a successful response" do
      get task_executions_path(task)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get task_execution_path(task, execution)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new record" do
        expect {
          post task_executions_path(task), params: valid_params
        }.to change(task.executions, :count).by(1)
      end

      it "returns a successful response status" do
        post task_executions_path(task), params: valid_params
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not create a new record" do
        expect {
          post task_executions_path(task), params: invalid_params
        }.not_to change(task.executions, :count)
      end

      it "returns an error response status" do
        post task_executions_path(task), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) { { execution: { user_id: user.id } } }

      before { create(:role, user_id: user.id, name: "execution.update") }

      it "updates the requested record" do
        patch task_execution_path(task, execution, user_id: user.id), params: new_params
        execution.reload
        expect(execution.user_id).to eq(new_params.dig(:execution, :user_id))
      end

      it "returns a successful status" do
        patch task_execution_path(task, execution, user_id: user.id), params: new_params
        execution.reload
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        patch task_execution_path(task, execution, user_id: user.id), params: invalid_params
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it "returns an error response status" do
        patch task_execution_path(task, execution, user_id: user.id), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid role" do
      before {
        execution.user.roles.last.update!(name: "invalid.role")
      }

      it "does not updates the record" do
        patch task_execution_path(task, execution, user_id: user.id), params: valid_params
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it "returns an error response status" do
        patch task_execution_path(task, execution, user_id: user.id), params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with valid role" do
      before { create(:role, user_id: user.id, name: "execution.destroy") }
      it "removes the requested record" do
        expect {
          delete task_execution_path(task, execution, user_id: user.id)
        }.to change(task.executions, :count).by(-1)
      end
    end

    context "with invalid role" do
      it "doesn't remove the requested record" do
        execution.user.roles.last.update!(name: "invalid.role")

        expect {
          delete task_execution_path(task, execution, user_id: user.id)
        }.not_to change(task.executions, :count)
      end
    end
  end
end
