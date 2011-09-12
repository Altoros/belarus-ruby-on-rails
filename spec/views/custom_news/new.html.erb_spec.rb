require 'spec_helper'

describe "custom_news/new.html.erb" do
  before(:each) do
    assign(:custom_news, stub_model(CustomNews,
      :name => "MyString",
      :title => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new custom_news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => custom_news_index_path, :method => "post" do
      assert_select "input#custom_news_name", :name => "custom_news[name]"
      assert_select "input#custom_news_title", :name => "custom_news[title]"
      assert_select "textarea#custom_news_content", :name => "custom_news[content]"
    end
  end
end
