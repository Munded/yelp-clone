require 'rails_helper'

module Restaurant_Helper

  def submit_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  def submit_alt_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "awesome"
    select '5', from: 'Rating'
    click_button 'Leave Review'
  end


  def alt_sign_up
    visit 'users/sign_up'
    fill_in 'Email', with: 'bob@name.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
  end

end