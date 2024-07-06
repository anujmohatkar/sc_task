require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  include_context "task user"

  before(:each) do
    assign(:task, Task.new(
      name: "MyString",
      status: "pending",
      due_date: Date.current,
      user: user
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[name]"

      assert_select "input[name=?]", "task[status]"
    end
  end
end
