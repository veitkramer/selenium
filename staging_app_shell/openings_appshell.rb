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

  def test_openings_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#change opening hours
    @driver.get "https://staging.shore.com/merchant/openings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    @driver.find_element(:css, "#merchant_profile_booking_hours_attributes_booking_hours_inherited").click
    sleep 5
    @driver.find_element(:css, "#merchant_profile_booking_hours_attributes_booking_hours_inherited").click
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(1) > label.checkbox > input").click
    sleep 5
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(1) > label.checkbox > input").click
#create closing times
    @driver.get "https://staging.shore.com/merchant/openings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    @driver.find_element(:css, "a.add_nested_fields").click
    @driver.find_element(:css, "div.closing_times > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
#delete closing times
  sleep 5
  @driver.find_element(:css, "div.tile-content > div:nth-of-type(2) > div:nth-of-type(5) > div.controls > a.remove_nested_fields").click
  @driver.find_element(:css, "div.closing_times > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
