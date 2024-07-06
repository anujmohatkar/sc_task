require 'rails_helper'

RSpec.describe Task, type: :model do
  include_context "task user"

  it 'is valid with valid attributes' do
    task = Task.new(name: "Valid Task Name", due_date: Date.tomorrow, user: user)
    expect(task).to be_valid
  end

  it 'is not valid without a name' do
    task = Task.new(due_date: Date.tomorrow, user: user)
    expect(task).to_not be_valid
  end

  it 'is not valid with a name shorter than 5 characters' do
    task = Task.new(name: "Task", due_date: Date.tomorrow, user: user)
    expect(task).to_not be_valid
  end

  it 'is not valid without a due date' do
    task = Task.new(name: "Valid Task Name", user: user)
    expect(task).to_not be_valid
  end

  it 'is not valid without a user' do
    task = Task.new(name: "Valid Task Name", due_date: Date.tomorrow)
    expect(task).to_not be_valid
  end

  it 'has a default status of pending' do
    task = Task.create(name: "Valid Task Name", due_date: Date.tomorrow, user: user)
    expect(task.status).to eq('pending')
  end

  it 'can change status to in_progress' do
    task = Task.create(name: "Valid Task Name", due_date: Date.tomorrow, user: user)
    task.in_progress!
    expect(task.status).to eq('in_progress')
  end

  it 'can change status to completed' do
    task = Task.create(name: "Valid Task Name", due_date: Date.tomorrow, user: user)
    task.completed!
    expect(task.status).to eq('completed')
  end

  it 'belongs to a user' do
    task = Task.create(name: "Valid Task Name", due_date: Date.tomorrow, user: user)
    expect(task.user).to eq(user)
  end
end