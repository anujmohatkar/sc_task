require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  include_context "task user"

  before(:each) do
    assign(:tasks, [
      Task.create!(
        name: "Name11",
        status: "pending",
        due_date: Date.current,
        user: user
      ),
      Task.create!(
        name: "Name11",
        status: "pending",
        due_date: Date.current,
        user: user
      )
    ])
  end

  it "renders a list of tasks" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>h5' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name11".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("pending"), count: 2
    assert_select cell_selector, text: Regexp.new(Date.current.to_s), count: 2
  end
end
