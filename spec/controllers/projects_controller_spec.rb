require 'rails_helper'

describe ProjectsController do

  describe "GET #index" do
    it "populates an array of projects"
    it "populates an array of pivotal tracker projects"
    it "renders the :index view"
  end

  describe "GET #show" do
    it "assigns the requested project to @project"
    it "renders the :show view"
  end

  describe "GET #new" do
    it "assigns a new Project to @project"
    it "assigns a new Membership to @membership"
    it "renders the :new view"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new project in the database"
      it "saves the new membership in the database"

      it "redirects to the tasks index page for this project"
    end

    context "with invalid attributes" do
      it "does not save the new project in the database"
      it "renders the :new view"
    end
  end

  describe "GET #edit" do
    it "assigns the requested Project to @project"
    it "renders the :edit template"
  end

  describe "POST #update" do
    context "with valid attributes" do
      it "updates the project in the database"
      it "redirects to the show page for this project"
    end

    context "with invalid attributes" do
      it "does not update the project in the database"
      it "renders the :edit template"
    end
  end

  describe "GET #destroy" do
    it "assigns the requested Project to @project"

    it "renders the :show template"
  end

end
