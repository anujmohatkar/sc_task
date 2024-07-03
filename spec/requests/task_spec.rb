require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }
  let(:other_user) { User.create!(email: "other@example.com", password: "password123") }
  let(:valid_attributes) { { name: "Valid Task", due_date: Date.tomorrow, status: "pending" } }

  before do
    sign_in user
  end

  describe "GET /tasks" do
    it "returns a success response" do
      Task.create! valid_attributes.merge(user: user)
      get tasks_path
      expect(response).to be_successful
    end

    it "only shows tasks belonging to the current user" do
      task1 = Task.create! valid_attributes.merge(user: user, name: "User's Task")
      task2 = Task.create! valid_attributes.merge(user: other_user, name: "Other's Task")
      get tasks_path
      expect(response.body).to include("User&#39;s Task")
      expect(response.body).not_to include("Other&#39;s Task")
    end
  end

  describe "GET /tasks/:id" do
    it "returns a success response for owned task" do
      task = Task.create! valid_attributes.merge(user: user)
      get task_path(task)
      expect(response).to be_successful
    end

    it "redirects if task doesn't belong to current user" do
      task = Task.create! valid_attributes.merge(user: other_user)
      get task_path(task)
      expect(response).to redirect_to(tasks_path)
      expect(flash[:alert]).to eq('You are not authorized to view this task.')
    end

    it "redirects if task doesn't exist" do
      get task_path(id: 999999)
      expect(response).to redirect_to(tasks_path)
      expect(flash[:alert]).to eq('You are not authorized to view this task.')
    end
  end

  describe "GET /tasks/new" do
    it "renders a successful response" do
      get new_task_path
      expect(response).to be_successful
    end
  end

  describe "POST /tasks" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "assigns the current user to the new Task" do
        post tasks_path, params: { task: valid_attributes }
        expect(Task.last.user).to eq(user)
      end
    end
  end
end