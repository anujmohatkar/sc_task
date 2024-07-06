# Confirmed Users and user sign in for Tasks requests and model specs
RSpec.shared_context "user authentication" do
  let(:user) { User.create!(email: "testspec@mail.com", password: "password123") }
  let(:other_user) { User.create!(email: "other@mail.com", password: "password123") }
  let(:valid_attributes) { { name: "Valid Task", due_date: Date.tomorrow, status: "pending" } }

  before do
    user.confirmed_at = Time.now
    user.save!
    other_user.confirmed_at = Time.now
    other_user.save!
    sign_in user
  end
end

# Users for Tasks View specs
RSpec.shared_context "task user" do
  let(:user) { User.create!(email: "testspec@mail.com", password: "password123") }

  before do
    user.confirmed_at = Time.now
    user.save!
  end
end