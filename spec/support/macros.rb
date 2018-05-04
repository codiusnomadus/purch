def sign_user_in(user, role="interviewer")
  user.add_role role
  sign_in user
end

def before_client_creation(user_role, path)
  sign_user_in(user, user_role)
  visit path
end

def create_client(location)
  fill_in "Name", with: "Google"
  select "Offshore Dev. Centre", from: "Type"
  select "CMS", from: "Industry"
  select location, from: "Location"

  fill_in "Description", with: "Google is a global search engine."
  click_button "Save"
end

def create_client_with_other_industry(location, industry_info)
  fill_in "Name", with: "Jonas"
  select "Internal", from: "Type"
  select "Other", from: "Industry"
  fill_in "client_industry_info", with: industry_info
  select location, from: "Location"
  fill_in "Description", with: "Jonas is a social network."
  click_button "Save"
end

def update_client(ind, loc, client)
  fill_in "client_name", with: "Alphabet"
  select ind, from: "client_industry_code"
  select loc, from: "client_location_country_code"
  fill_in "client_description", with: "Google is now owned by Alphabet."
  click_button "Save"
  expect(page).to have_content('Client was successfully updated.')
  expect(page.current_path).to eq(client_path(client))
  expect(page).to have_css("h1", text: "Alphabet")
  expect(page).to have_content("Name: Alphabet")
  expect(page).to have_content("Google is now owned by Alphabet.")
end

def second_client_factory(type_name, type_code, loc_name, loc_code, ind_name, ind_code, ind_group)
  type_2 = create(:client_type, name: type_name, client_type_code: type_code)
  location_2 = create(:country, name: loc_name, country_code: loc_code)
  industry_2 = create(:industry, name: ind_name, industry_code: ind_code, industry_group: ind_group)
end

def codify_name(factory_name)
  factory_name.parameterize('_').upcase
end