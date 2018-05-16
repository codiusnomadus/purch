require 'rails_helper'

feature "Deal deletion" do
  let(:jon) { create(:user)}
  let!(:deal) { create(:deal) }

  before do
    deal.user = jon
    deal.save
  end

  it "allows admin users to delete deals" do
    sign_user_in(jon)

    visit deal_path(deal)

    expect(page).to have_css(:h1, text: deal.title)
    expect(page).to have_css('li a i.fa.fa-trash')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_content('Deal has been deleted successfully.')
  end

  it "allows editor users to delete deals" do
    sign_user_in(jon, 'editor')

    visit deal_path(deal)

    expect(page).to have_css(:h1, text: deal.title)
    expect(page).to have_css('li a.btn-delete')

    page.find(:css, 'li a.btn-delete').click

    expect(page).to have_content('Deal has been deleted successfully.')

    expect(page).to have_content('Deal has been deleted successfully.')
  end

  it "does not allow editor users to delete other deals" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit deal_path(deal)

    expect(page).to have_css(:h1, text: deal.title)
    expect(page).to_not have_css('li a', text: 'Delete deal')
  end

  it "does not allow non-users to delete deals" do
    visit deal_path(deal)

    expect(page).to have_content('You are not authorized to perform this action.')
  end

  it "does not allow subscriber users to delete deals" do
    sign_user_in(jon, 'subscriber')

    visit deal_path(deal)

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
