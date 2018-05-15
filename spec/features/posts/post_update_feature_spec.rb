require 'rails_helper'

feature "Post update " do
  let(:jon) { create(:user)}
  let!(:post) { create(:post) }

  before do
    post.update_attributes(user: jon)
  end

  it "allows admin users to edit posts" do
    sign_user_in(jon)

    visit edit_post_path(post)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    click_button 'Update Post'

    expect(page).to have_content('Post has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. iPhone')
    expect(page).to have_content('This laptop was designed in Korea.')
  end

  it "allows editor users to edit own posts" do
    sign_user_in(jon, 'editor')

    visit edit_post_path(post)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: 'This laptop was designed in Korea.'
    click_button 'Update Post'

    expect(page).to have_content('Post has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Samsung vs. iPhone')
    expect(page).to have_content('This laptop was designed in Korea.')
  end

  it "does not allow editor users to edit other posts" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit post_path(post)
    expect(page).to_not have_css('li a', text: 'Edit post')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit edit_post_path(post)

    fill_in 'Title', with: 'Samsung vs. iPhone'
    fill_in 'Body', with: ''
    click_button 'Update Post'

    expect(page).to have_content('Post could not be updated.')
  end

  it "does not allow non-users to edit posts" do
    visit edit_post_path(post)

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to edit posts" do
    sign_user_in(jon, 'subscriber')

    visit edit_post_path(post)

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
