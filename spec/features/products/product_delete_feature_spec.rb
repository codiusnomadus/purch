require 'rails_helper'

feature "Product deletion" do
  let(:jon) { create(:user)}
  let!(:laptop) { create(:product) }

  before do
    laptop.user = jon
    laptop.save
  end

  it "allows admin users to delete products" do
    sign_user_in(jon)

    visit product_path(laptop)

    expect(page).to have_css(:h1, text: laptop.name)
    expect(page).to have_css('li a', text: 'Delete product')

    click_link 'Delete product'

    expect(page).to have_css(:h1, text: 'All products')
    expect(page).to have_content('Product has been deleted successfully.')
  end

  it "allows editor users to delete products" do
    sign_user_in(jon, 'editor')

    visit product_path(laptop)

    expect(page).to have_css(:h1, text: laptop.name)
    expect(page).to have_css('li a', text: 'Delete product')

    click_link 'Delete product'

    expect(page).to have_content('Product has been deleted successfully.')

    expect(page).to have_css(:h1, text: 'All products')
    expect(page).to have_content('Product has been deleted successfully.')
  end

  it "does not allow editor users to delete other products" do
    ned = create(:user)
    sign_user_in(ned, 'editor')

    visit product_path(laptop)

    expect(page).to have_css(:h1, text: laptop.name)
    expect(page).to_not have_css('li a', text: 'Delete product')
  end

  it "does not allow non-users to delete products" do
    visit product_path(laptop)

    expect(page).to have_css(:h1, text: laptop.name)
    expect(page).to_not have_css('li a', text: 'Delete product')
  end

  it "does not allow subscriber users to delete products" do
    sign_user_in(jon, 'subscriber')

    visit product_path(laptop)

    expect(page).to have_css(:h1, text: laptop.name)
    expect(page).to_not have_css('li a', text: 'Delete product')
  end
end
