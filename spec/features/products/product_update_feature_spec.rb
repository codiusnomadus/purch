require 'rails_helper'

feature "Product update" do
  let(:jon) { create(:user)}
  let!(:laptop) { create(:product) }

  before do
    laptop.update_attributes(user: jon)
  end

  it "allows admin users to edit products" do
    sign_user_in(jon)

    visit edit_product_path(laptop)

    fill_in 'Name', with: 'Macbook Pro'
    fill_in 'Price', with: '19.99'
    click_button 'Update Product'

    expect(page).to have_content('Product has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Macbook Pro')
    expect(page).to have_content('19.99')
  end

  it "allows editor users to edit own products" do
    sign_user_in(jon, 'editor')

    visit edit_product_path(laptop)

    fill_in 'Name', with: 'Macbook Pro'
    fill_in 'Price', with: '19.99'
    click_button 'Update Product'

    expect(page).to have_content('Product has been updated successfully.')

    expect(page).to have_css(:h1, text: 'Macbook Pro')
    expect(page).to have_content('19.99')
  end

  it "does not allow editor users to edit other products" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit product_path(laptop)
    expect(page).to_not have_css('li a.btn-edit')
  end

  it "does not allow editors to leave blank fields" do
    sign_user_in(jon, 'editor')

    visit edit_product_path(laptop)

    fill_in 'Name', with: 'Laptop'
    fill_in 'Description', with: ''
    fill_in 'Price', with: '10.99'
    attach_file('Upload', Rails.root.join('spec', 'factories', 'logo.png'))
    click_button 'Update Product'

    expect(page).to have_content('Product could not be updated.')
  end

  it "does not allow non-users to edit products" do
    visit edit_product_path(laptop)

    expect(page).to have_css(:h2, text: 'Log in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it "does not allow subscriber users to edit products" do
    sign_user_in(jon, 'subscriber')

    visit edit_product_path(laptop)

    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
