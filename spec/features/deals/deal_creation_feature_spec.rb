require 'rails_helper'

feature "Deal creation" do
  let(:jon) { create(:user)}
  let!(:brand) { create(:brand) }

  it "allows admin users to create deals" do
    sign_user_in(jon)

    visit new_deal_path

    fill_in 'Title', with: '50% discount on iPhone'
    select brand.name, from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Deal'

    expect(page).to have_content('Deal has been created successfully.')

    expect(page).to have_css(:h1, text: '50% discount on iPhone')
    expect(page).to have_content('Apple')
    expect(page).to have_content('100')
    expect(page).to have_content('COOLBUY')
    expect(page).to have_content('Savings of upto 50%')
    expect(page).to have_content('Get this deal')
  end

  it "allows editor users to create deals" do
    sign_user_in(jon, 'editor')

    visit new_deal_path

    fill_in 'Title', with: '50% discount on iPhone'
    select brand.name, from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Deal'

    expect(page).to have_content('Deal has been created successfully.')

    expect(page).to have_css(:h1, text: '50% discount on iPhone')
    expect(page).to have_content('Apple')
    expect(page).to have_content('100')
    expect(page).to have_content('COOLBUY')
    expect(page).to have_content('Savings of upto 50%')
    expect(page).to have_content('Get this deal')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit new_deal_path

    fill_in 'Title', with: ''
    select brand.name, from: 'Brand'
    fill_in 'Price', with: '100'
    fill_in 'Discount code', with: 'COOLBUY'
    fill_in 'Savings', with: 'Savings of upto 50%'
    fill_in 'Link', with: 'http://example.com'
    # attach_file('Image', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Deal'

    expect(page).to have_content('Deal could not be created.')
  end

  it "does not allow non-users to create deals" do
    visit new_deal_path

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to create deals" do
    sign_user_in(jon, 'subscriber')

    visit new_deal_path

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
