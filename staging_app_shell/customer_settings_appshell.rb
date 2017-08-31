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

  def test_customer_settings_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 5
    @driver.get "https://staging.shore.com/merchant/customer_settings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    @driver.find_element(:css, "#yield > div > div.row-fluid > div > div > div.tile-autoload > a").click
    @driver.find_element(:css, "#booking_definition_attribute_definition_name").send_keys "Chromedriver"
    @driver.find_element(:css, "a.chosen-single > span").click
    @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(2)").click
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "#booking_definition_customer-attribute-chromedriver > div.controls.column > a.btn > i.icon-remove").click
    @driver.switch_to.alert.accept
    sleep 3

  end


  def verify(&blk)‚
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
