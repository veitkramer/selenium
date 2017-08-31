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

  def test_create_appt_customer

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size
    
#create appointment and create customer
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

    @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click
    @driver.find_element(:css,"i.shore-icon-backend-new-customer.text-muted").click
    sleep 4
    @driver.find_element(:name, "firstName").clear
    @driver.find_element(:name, "firstName").send_keys "Auto"
    @driver.find_element(:name, "lastName").clear
    @driver.find_element(:name, "lastName").send_keys "Bro"
    @driver.find_element(:name, "email").clear
    @driver.find_element(:name, "email").send_keys "auto@shore.com"
    @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#delete customer
    @driver.get "https://staging.shore.com/merchant/app/customers"
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input[type=\"text\"]").clear
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input[type=\"text\"]").send_keys "Auto"
    sleep 4
    @driver.find_element(:css, "span.mtw-column-action-delete-row").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-danger.btn-sm.mtw-column-confirm-action-delete-row").click
    sleep 2

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
