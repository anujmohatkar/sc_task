require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }
  
  before(:each) do
    assign(:task, Task.create!(
      name: "Name22",
      status: 2,
      due_date: Date.current,
      user: user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name22/)
    expect(rendered).to match(/2/)
  end
end
