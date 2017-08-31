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

  def test_create_appt

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

    @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click

    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:xpath, "//div[@id='widgetManagerContainer']/div/div/div/div[2]/div[2]/div/div/div/div/div/div[2]/div[4]/div/div/div/div/div/a/div/div").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(4) > div > div.has-feedback > div > ul > li > input").send_keys "After"
    @driver.action.send_keys(:enter).perform
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(5) > div > div.has-feedback > div > ul > li > input").send_keys "James"
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "button.btn.btn-primary").click





  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
