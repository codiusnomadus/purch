require 'rails_helper'

feature "Product creation" do
  let(:jon) { create(:user)}
  let!(:brand) { create(:brand) }

  it "allows admin users to create products" do
    sign_user_in(jon)

    visit new_product_path

    fill_in 'Name', with: 'Laptop'
    select brand.name, from: 'Brand'
    fill_in 'Description', with: 'This laptop was designed in Korea.'
    fill_in 'Price', with: '10.99'
    attach_file('Upload', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Product'

    expect(page).to have_content('Product has been created successfully.')

    expect(page).to have_css(:h1, text: 'Laptop')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('10.99')
  end

  it "allows editor users to create products" do
    sign_user_in(jon, 'editor')

    visit new_product_path

    fill_in 'Name', with: 'Laptop'
    select brand.name, from: 'Brand'
    fill_in 'Description', with: 'This laptop was designed in Korea.'
    fill_in 'Price', with: '10.99'
    attach_file('Upload', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Product'

    expect(page).to have_content('Product has been created successfully.')

    expect(page).to have_css(:h1, text: 'Laptop')
    expect(page).to have_content('This laptop was designed in Korea.')
    expect(page).to have_content('10.99')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit new_product_path

    fill_in 'Name', with: 'Laptop'
    select brand.name, from: 'Brand'
    fill_in 'Description', with: ''
    fill_in 'Price', with: '10.99'
    attach_file('Upload', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Create Product'

    expect(page).to have_content('Product could not be created.')
  end

  it "does not allow non-users to create products" do
    visit new_product_path

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to create products" do
    sign_user_in(jon, 'subscriber')

    visit new_product_path

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
