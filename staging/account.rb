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

  def test_account
    
    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click


#change account language
@driver.find_element(:css, "#btnCloseMainNav").click
@driver.find_element(:id, "dropdownMenu1").click
@driver.find_element(:css, "body > header > div > div.header-account > div.dropdown.current-account-details.open > ul > li:nth-child(1) > a").click
sleep 2
@driver.find_element(:css, "#merchant_key_account_locale_chosen > a").click
sleep 4
@driver.find_element(:css, "#merchant_key_account_locale_chosen > div > ul > li:nth-child(3)").click
sleep 2
@driver.find_element(:css, "#edit_merchant_key_account_2 > div.tile-footer > input").click
sleep 3
verify { assert_equal "Language", @driver.find_element(:css, "div.row-fluid > div:nth-of-type(2) > div:nth-of-type(1) > div.tile-header > h2").text }
sleep 2
@driver.find_element(:css, "#merchant_key_account_locale_chosen > a").click
sleep 2
@driver.find_element(:css, "#merchant_key_account_locale_chosen > div > ul > li:nth-child(1)").click
sleep 2
@driver.find_element(:css, "#edit_merchant_key_account_2 > div.tile-footer > input").click
sleep 3
verify { assert_equal "Sprache", @driver.find_element(:css, "div.row-fluid > div:nth-of-type(2) > div:nth-of-type(1) > div.tile-header > h2").text }





  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
