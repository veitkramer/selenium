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

  def test_customer_settings
#login
    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
#go to costumer attributes
    sleep 5
    @driver.get "https://secure.shore.com/merchant/customer_settings?appshell=true&merchant_profile_id=01f0df74-5c9e-427b-9f1d-e469a35891a1"
    sleep 5
    @driver.find_element(:css, "div#yield div.tile-autoload > a").click
    @driver.find_element(:css, "#booking_definition_attribute_definition_name").send_keys "Chromedriver"
    @driver.find_element(:css, "a.chosen-single > span").click
    @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(2)").click
    @driver.action.send_keys(:enter).perform
    sleep 3
    assert(@driver.find_element(:css => "#booking_definition_customer-attribute-chromedriver div.span4.name.column > a").text.include?("Chromedriver"),"Assertion Pass")
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
