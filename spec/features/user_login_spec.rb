require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
       # SETUP
       before :each do
        User.create!(
          first_name: 'User',
          last_name: 'testUser',
          email: 'test@test.com',
          password: '123',
          password_confirmation: '123'
        )
      end
      
      scenario "User logs in" do
        #ACT
        visit login_path
        fill_in'email', with:'test@test.com'
        fill_in'password', with:'123'
        click_button("Submit")

        #DEBUG 
        save_screenshot

        #VERIFY
        expect(page).to have_content('Signed in as test@test.com')



      end
end
