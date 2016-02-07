require 'spec_helper'

describe "applications/index" do
  before(:each) do
    assign(:applications, [
      stub_model(Application,
        :username => "Username",
        :email => "Email",
        :level => 1,
        :about => "MyText",
        :thlevel => 2,
        :status => "Status"
      ),
      stub_model(Application,
        :username => "Username",
        :email => "Email",
        :level => 1,
        :about => "MyText",
        :thlevel => 2,
        :status => "Status"
      )
    ])
  end

  it "renders a list of applications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
