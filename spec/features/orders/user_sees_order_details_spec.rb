require 'rails_helper'

describe "When I visit an order" do
  context "As an authenticated user" do
    scenario "I see each freelancer with quantity and subtotal" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      freelancer_1 = create(:freelancer)
      freelancer_2 = create(:freelancer)
      order = user.orders.create(status: "Paid")

      2.times {order.freelancers << freelancer_2}
      order.freelancers << freelancer_1

      visit order_path(order)

      expect(page).to have_content("Paid")
      expect(page).to have_content("Date: #{order.created_at.strftime(format='%m/%d/%Y: %H:%M:%S %Z')}")

      expect(page).to have_content("Name")
      expect(page).to have_content("1 hour")
      expect(page).to have_content("$150")
      expect(page).to have_content("Total: $450")
      expect(page).to_not have_content("Updated on:")

      first(:link, "View Freelancer").click
      expect(current_path).to eq(freelancer_path(freelancer_1))
    end

    scenario "if the order is cancelled or completed there is a different date shown" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      freelancer_1 = create(:freelancer)
      order = user.orders.create(status: "Completed")
      order.freelancers << freelancer_1

      visit order_path(order)


      expect(page).to have_content("Completed")
      expect(page).to have_content("Date: #{order.created_at.strftime(format='%m/%d/%Y: %H:%M:%S %Z')}")
      expect(page).to have_content("Updated on: #{order.updated_at.strftime(format='%m/%d/%Y: %H:%M:%S %Z')}")

    end


  end
end
