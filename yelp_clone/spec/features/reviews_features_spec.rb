require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  before(:each) do
    visit 'users/sign_up'
    fill_in 'Email', with: 'name@name.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
  end

  def submit_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  def alt_sign_up
    visit 'users/sign_up'
    fill_in 'Email', with: 'bob@name.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
  end

  scenario 'allows users to leave a review using a form' do
    submit_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
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

end