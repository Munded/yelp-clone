require 'rails_helper'
require 'helpers/helper_spec'

feature 'reviewing' do
  include Restaurant_Helper

  before {Restaurant.create name: 'KFC'}

  before(:each) do
    visit 'users/sign_up'
    fill_in 'Email', with: 'name@name.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
  end


  scenario 'allows users to leave a review using a form' do
    submit_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'user can only leave one review per restaurants' do
    submit_review
    submit_alt_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'already reviewed this restaurant' 
  end

  scenario 'user that created review can delete it' do
    submit_review
    click_link 'Delete Review'
    expect(page).not_to have_content('so so')
  end

  scenario 'user that did not create review cannot delete it' do
    click_link 'Sign out'
    alt_sign_up
    submit_review
    click_link 'Delete Review'
    expect(page).not_to have_content('so so')
  end

  scenario 'displays an average rating' do
    submit_review
    click_link 'Sign out'
    alt_sign_up
    submit_alt_review
    expect(page).to have_content('Average rating: 4')
  end
end