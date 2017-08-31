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

  def test_create_appt

    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
    @driver.find_element(:css, "div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "div.as-Header-addActions > a:first-child").click
    sleep 2
    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(1) > div.row > div.text-primary.text-truncate").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "button.btn.btn-primary").click

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
