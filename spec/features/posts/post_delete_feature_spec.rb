require 'rails_helper'

feature "Post deletion" do
  let(:jon) { create(:user)}
  let!(:post) { create(:post) }

  before do
    post.user = jon
    post.save
  end

  it "allows admin users to delete posts" do
    sign_user_in(jon)

    visit post_path(post)

    expect(page).to have_css(:h1, text: post.title)
    expect(page).to have_css('li a i.fa.fa-trash')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_css(:h1, text: 'Blog')
    expect(page).to have_content('Post has been deleted successfully.')
  end

  it "allows editor users to delete posts" do
    sign_user_in(jon, 'editor')

    visit post_path(post)

    expect(page).to have_css(:h1, text: post.title)
    expect(page).to have_css('li a.btn-delete')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_content('Post has been deleted successfully.')

    expect(page).to have_css(:h1, text: 'Blog')
    expect(page).to have_content('Post has been deleted successfully.')
  end

  it "does not allow editor users to delete other posts" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit post_path(post)

    expect(page).to have_css(:h1, text: post.title)
    expect(page).to_not have_css('li a', text: 'Delete post')
  end

  it "does not allow non-users to delete posts" do
    visit post_path(post)

    expect(page).to have_css(:h1, text: post.title)
    expect(page).to_not have_css('li a', text: 'Delete post')
  end

  it "does not allow subscriber users to delete posts" do
    sign_user_in(jon, 'subscriber')

    visit post_path(post)

    expect(page).to have_css(:h1, text: post.title)
    expect(page).to_not have_css('li a', text: 'Delete post')
  end
end
