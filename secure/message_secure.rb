require "json"
require "selenium-webdriver"
require "test/unit"

class LogIn < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://secure.shore.com/merchant/sign_in"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_create_customer

    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
#change create meassage
@driver.find_element(:css, "div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "div.as-Header-addActions > a:nth-of-type(3)").click
    sleep 2
    @driver.find_element(:css, "div.mmw-contacts-container > div:nth-of-type(2) > table.table.mmw-contacts-table > tbody.mmw-table-body.mmw-table-list > tr:nth-of-type(1) > td:nth-of-type(2)").click
    sleep 2
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "was geht hier ab?"
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 3
    assert(@driver.find_element(:css => "div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text.include?("was geht hier ab?"),"Assertion Pass")
sleep 3
#create message via customer details
    @driver.get "https://my.shore.com/customers"
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").clear
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Auto"
    @driver.find_element(:css, "div#asMain tbody > tr:nth-child(1) > td:nth-child(2)").click
    sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-new-message").click
    sleep 2
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "was geht hier ab?"
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 3
    assert(@driver.find_element(:css => "div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text.include?("was geht hier ab?"),"Assertion Pass")
    sleep 4

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
