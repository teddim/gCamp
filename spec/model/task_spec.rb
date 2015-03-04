require 'rails_helper'

describe Task do

  it "Requires a description - Invalid Test" do
    @task = Task.create(due_date: 20150303)
    expect(@task).to be_invalid
  end

  it "Requires a description - Valid Test" do
    @task = Task.create(description:'Here is a task', due_date: 20150303)
    expect(@task).to be_valid
  end
end
