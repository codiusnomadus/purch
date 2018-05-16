require 'rails_helper'

feature "Deal update " do
  let(:jon) { create(:user)}
  let!(:deal) { create(:deal) }

  before do
    deal.update_attributes(user: jon)
  end

  it "allows admin users to edit deals" do
    sign_user_in(jon)

    visit edit_deal_path(deal)

    fill_in 'Title', with: '50% discount on iPhone'
    select 'Apple', from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Update Deal'

    expect(page).to have_content('Deal has been updated successfully.')

    expect(page).to have_css(:h1, text: '50% discount on iPhone')
    expect(page).to have_content('Apple')
    expect(page).to have_content('100')
    expect(page).to have_content('COOLBUY')
    expect(page).to have_content('Savings of upto 50%')
    expect(page).to have_content('Get this deal')
  end

  it "allows editor users to edit own deals" do
    sign_user_in(jon, 'editor')

    visit edit_deal_path(deal)

    fill_in 'Title', with: '50% discount on iPhone'
    select 'Apple', from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Update Deal'

    expect(page).to have_content('Deal has been updated successfully.')

    expect(page).to have_css(:h1, text: '50% discount on iPhone')
    expect(page).to have_content('Apple')
    expect(page).to have_content('100')
    expect(page).to have_content('COOLBUY')
    expect(page).to have_content('Savings of upto 50%')
    expect(page).to have_content('Get this deal')
  end

  it "does not allow editor users to edit other deals" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit deal_path(deal)
    expect(page).to_not have_css('li a', text: 'Edit deal')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit edit_deal_path(deal)

    fill_in 'Title', with: ''
    select 'Apple', from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Update Deal'

    expect(page).to have_content('Deal could not be updated.')
  end

  it "does not allow non-users to edit deals" do
    visit edit_deal_path(deal)

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to edit deals" do
    sign_user_in(jon, 'subscriber')

    visit edit_deal_path(deal)

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
