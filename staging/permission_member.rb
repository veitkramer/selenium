require "json"
require "selenium-webdriver"
require "test/unit"

class LogIn < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://staging.shore.com/merchant/sign_in"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_permission_member

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js+ted@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "[STAGING] Shore - Manage your customers", @driver.title }
    @driver.get "https://staging.shore.com/merchant/appointments/weekly"
    verify { assert_not_include @driver.find_element(:id, "navContainer").text, "Mitarbeiter" }
    verify { assert_not_include @driver.find_element(:id, "navContainer").text, "Newsletter" }
    verify { assert_not_include @driver.find_element(:id, "navContainer").text, "AdWords" }
    verify { assert_not_include @driver.find_element(:id, "navContainer").text, "Einstellungen" }


end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
