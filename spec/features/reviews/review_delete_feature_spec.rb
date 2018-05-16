require 'rails_helper'

feature "Review deletion" do
  let(:jon) { create(:user)}
  let!(:review) { create(:review) }

  before do
    review.user = jon
    review.save
  end

  it "allows admin users to delete reviews" do
    sign_user_in(jon)

    visit review_path(review)

    expect(page).to have_css(:h1, text: review.title)
    expect(page).to have_css('li a i.fa.fa-trash')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_css(:h1, text: 'Reviews')
    expect(page).to have_content('Review has been deleted successfully.')
  end

  it "allows editor users to delete reviews" do
    sign_user_in(jon, 'editor')

    visit review_path(review)

    expect(page).to have_css(:h1, text: review.title)
    expect(page).to have_css('li a.btn-delete')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_content('Review has been deleted successfully.')

    expect(page).to have_css(:h1, text: 'Reviews')
    expect(page).to have_content('Review has been deleted successfully.')
  end

  it "does not allow editor users to delete other reviews" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit review_path(review)

    expect(page).to have_css(:h1, text: review.title)
    expect(page).to_not have_css('li a', text: 'Delete review')
  end

  it "does not allow non-users to delete reviews" do
    visit review_path(review)

    expect(page).to have_css(:h1, text: review.title)
    expect(page).to_not have_css('li a', text: 'Delete review')
  end

  it "does not allow subscriber users to delete reviews" do
    sign_user_in(jon, 'subscriber')

    visit review_path(review)

    expect(page).to have_css(:h1, text: review.title)
    expect(page).to_not have_css('li a', text: 'Delete review')
  end
end
