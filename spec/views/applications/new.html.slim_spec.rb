require 'spec_helper'

describe "applications/new" do
  before(:each) do
    assign(:application, stub_model(Application,
      :username => "MyString",
      :email => "MyString",
      :level => 1,
      :about => "MyText",
      :thlevel => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new application form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", applications_path, "post" do
      assert_select "input#application_username[name=?]", "application[username]"
      assert_select "input#application_email[name=?]", "application[email]"
      assert_select "input#application_level[name=?]", "application[level]"
      assert_select "textarea#application_about[name=?]", "application[about]"
      assert_select "input#application_thlevel[name=?]", "application[thlevel]"
      assert_select "input#application_status[name=?]", "application[status]"
    end
  end
end
