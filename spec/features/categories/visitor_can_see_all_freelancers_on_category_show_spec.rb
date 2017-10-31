require 'rails_helper'
describe "As a Visitor" do
  describe "when I visit '/:CATEGORY_NAME'" do
    scenario "I can see all freelancers in the category" do
      category_1 = create(:category)
      category_2 = create(:category)
      freelancer_1 = create(:freelancer, category: category_1)
      freelancer_2 = create(:freelancer, category: category_2)

      visit category_path(category_1)

      expect(page).to have_content(category_1.freelancers.first.name)
      expect(page).to_not have_content(category_2.freelancers.first.name)
    end
  end
end
