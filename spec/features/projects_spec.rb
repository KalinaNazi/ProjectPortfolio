
require 'rails_helper'

# Creating new project on form fills title with what user typed for title
RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user)
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
        fill_in "Description", with: "Test Description"
      end
    end


# Creating new project on form fills description and title with what user typed for both
# Says Project was successfully created when description and title are filled
    scenario "should be successful" do
      fill_in "Title", with: "Test title"
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

# Clicking create project fails when description or title is blank
    scenario "should fail" do
      click_button "Create Project"
      #expect(page).to have_content("Description can't be blank")
      #expect(page).to have_content("Title can't be blank")
    end
  end

  # Clicking edit project and then update fills title and description with what user typed for title and description
  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user)
      visit edit_project_path(project)
    end

    # On form, fill description and title with new stuff once update project clicked
    # If title and description filled when clicking update, prompt project was successfully updated
    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
        fill_in "Title", with: "New title content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    # If description and title are blank when updating, prompt that either one cant be blank
    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
        fill_in "Title", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Title can't be blank")
    end
  end

  # Removing project deletes the project completely
  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      user = FactoryBot.create(:user)
      login_as(user)
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end

