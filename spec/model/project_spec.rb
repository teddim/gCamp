require 'rails_helper'

describe Project do

  it "Requires a name - Invalid Test" do
    @project = Project.create()
    expect(@project).to be_invalid
  end

  it "Requires a name - Valid Test" do
    @project = Project.create(name:'Here is a project')
    expect(@project).to be_valid
  end
end
