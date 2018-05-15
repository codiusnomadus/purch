require 'rails_helper'

feature "Review update " do
  let(:jon) { create(:user)}
  let!(:review) { create(:review) }

  before do
    review.update_attributes(user: jon)
  end

  it "allows admin users to edit reviews" do
    sign_user_in(jon)

    visit edit_review_path(review)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    fill_in 'Verdict', with: 'Buy'
    click_button 'Update Review'

    expect(page).to have_content('Review has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. iPhone')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('Buy')
  end

  it "allows editor users to edit own reviews" do
    sign_user_in(jon, 'editor')

    visit edit_review_path(review)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    fill_in 'Verdict', with: 'Buy'
    click_button 'Update Review'

    expect(page).to have_content('Review has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. iPhone')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('Buy')
  end

  it "does not allow editor users to edit other reviews" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit review_path(review)
    expect(page).to_not have_css('li a', text: 'Edit review')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit edit_review_path(review)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: ''
    fill_in 'Verdict', with: 'Buy'
    click_button 'Update Review'

    expect(page).to have_content('Review could not be updated.')
  end

  it "does not allow non-users to edit reviews" do
    visit edit_review_path(review)

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to edit reviews" do
    sign_user_in(jon, 'subscriber')

    visit edit_review_path(review)

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
