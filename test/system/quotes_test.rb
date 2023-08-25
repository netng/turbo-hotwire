require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    # @quote = quotes(:first) # quutes(:first) mereferensikan quote pertama pada file quotes.yml di folder fixtures
    login_as users(:accountant) # method login_as ini berasal dari Warden Helper yang di include di file application_system_test_case.rb
    @quote = Quote.ordered.first
  end
  
  test "Quote page index" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"
  end

  test "Create a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "New quote"
    fill_in "Name", with: "My first quote"

    assert_selector "h1", text: "Quotes"
    click_on "Create quote"

    assert_selector "h1", text: "Quotes"
    assert_text "My first quote"
  end

  test "Showing a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_link @quote.name
    assert_selector "h1", text: @quote.name
  end

  test "Updating a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated quote"

    assert_selector "h1", text: "Quotes"
    click_on "Update quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote"
  end

  test "Destroying a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end

end
