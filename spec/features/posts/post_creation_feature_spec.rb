require 'rails_helper'

feature "Post creation" do
  let(:jon) { create(:user)}
  # let!(:category) { create(:category)}

  it "allows admin users to create posts" do
    category = create(:category)
    sign_user_in(jon)

    visit new_post_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    select category.name, from: 'Category'
    # fill_in 'Verdict', with: 'Buy'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Post'

    expect(page).to have_content('Post has been created successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. Apple')
    expect(page).to have_content('This laptop was designed in Korea.')
  end

  it "allows editor users to create posts" do
    category = create(:category)
    sign_user_in(jon, 'editor')

    visit new_post_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    select category.name, from: 'Category'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. Apple')
    expect(page).to have_content('This laptop was designed in Korea.')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit new_post_path

    fill_in 'Title', with: 'Samsung vs. Apple'
    fill_in 'Body', with: ''
    click_button 'Create Post'

    expect(page).to have_content('Post could not be created.')
  end

  it "does not allow non-users to create posts" do
    visit new_post_path

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to create posts" do
    sign_user_in(jon, 'subscriber')

    visit new_post_path

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
