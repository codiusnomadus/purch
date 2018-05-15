require 'rails_helper'

feature "Review creation" do
  let(:jon) { create(:user)}

  it "allows admin users to create reviews" do
    sign_user_in(jon)

    visit new_review_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Excerpt', with: 'This laptop was designed in Korea.'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    fill_in 'Verdict', with: 'Buy'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Review'

    expect(page).to have_content('Review has been created successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. Apple')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('Buy')

  end

  it "allows editor users to create reviews" do
    sign_user_in(jon, 'editor')

    visit new_review_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Excerpt', with: 'This laptop was designed in Korea.'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    fill_in 'Verdict', with: 'Buy'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Review'

    expect(page).to have_content('Review has been created successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. Apple')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('Buy')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit new_review_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Body', with: ''
    fill_in 'Verdict', with: 'Buy'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Review'

    expect(page).to have_content('Review could not be created.')
  end

  it "does not allow non-users to create reviews" do
    visit new_review_path

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to create reviews" do
    sign_user_in(jon, 'subscriber')

    visit new_review_path

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
