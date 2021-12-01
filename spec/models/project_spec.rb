
require "rails_helper"

# From the models validates_presence_of, checks if description is empty 
RSpec.describe Project, type: :model do
  context "validations tests" do
    it "ensures the description is present" do
      project = Project.new(description: "Content of the description")
      expect(project.valid?).to eq(false)
    end

# From the models validates_presence_of, checks if title is empty
    it "ensures the title is present" do
        project = Project.new(title: "Content of the title")
        expect(project.valid?).to eq(false)
      end

# When saving new project, validates that title and description isnt empty
    it "should be able to save project" do
      project = Project.new(title: "Title", description: "Some description content goes here")
      expect(project.save).to eq(true)
    end
  end

  context "scopes tests" do

  end
end

# Creates three projects and returns all three
RSpec.describe Project, type: :model do
  # ...

  context "scopes tests" do
    let(:params) { { title: "Title", description: "some description" } }
    before(:each) do
      Project.create(params)
      Project.create(params)
      Project.create(params)
    end

    it "should return all projects" do
      expect(Project.count).to eq(3)
    end

  end
end

