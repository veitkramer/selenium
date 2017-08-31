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

  def test_log_out

#log in
    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 3
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 6
#log out
    @driver.find_element(:css, "div#asMain a.as-Button.as-Header-logoButton > img").click
    sleep 3
    @driver.find_element(:css, "div#asMain section.dashboard-app--2LqH1fQ1npzDrg-nbSFkhf > ul > li:nth-child(2) > a > i").click
    sleep 3
    verify { assert_equal @driver.find_element(:css, "div > div.alert.alert-notice").text, "Signed out successfully." }
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
