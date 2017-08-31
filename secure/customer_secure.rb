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
#creates a new customer / delete the customer afterwards
      @driver.find_element(:css, "div.as-Header-addActionsContainer > a").click
      sleep 4
      @driver.find_element(:css, "div.as-Header-addActions > a:nth-of-type(2)").click
      sleep 4
      @driver.find_element(:css, "div#asMain div:nth-child(1) > div > div > a").click
      sleep 4
      @driver.find_element(:css, "ul.dropdown-menu > li:first-child > a").click
      sleep 2
      @driver.find_element(:xpath, "(//input[@id=''])[1]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[1]").send_keys "Auto"
      @driver.find_element(:xpath, "(//input[@id=''])[2]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[2]").send_keys "Chromedriver"
      @driver.find_element(:xpath, "(//input[@id=''])[3]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[3]").send_keys "auto@shore.com"
      @driver.find_element(:xpath, "(//input[@id=''])[4]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[4]").send_keys "+49 174 2499358"
      @driver.find_element(:xpath, "(//input[@id=''])[5]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[5]").send_keys "18.02.1999"
      @driver.find_element(:xpath, "(//input[@id=''])[6]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[6]").send_keys "Teststraße 10"
      @driver.find_element(:xpath, "(//input[@id=''])[7]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[7]").send_keys "8000"
      @driver.find_element(:xpath, "(//input[@id=''])[8]").clear
      @driver.find_element(:xpath, "(//input[@id=''])[8]").send_keys "Selenium"
      @driver.find_element(:css, "button.btn.btn-primary").click
      assert_equal @driver.find_element(tag_name: 'body').text.include?("Auto"), false
      sleep 4
#delete customer
    @driver.get "https://my.shore.com/customers"
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").clear
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Auto"
      sleep 4
      @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(7) > div.mtw-column-actions > span.mtw-column-action-delete-row").click
      sleep 2
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm.mtw-column-confirm-action-delete-row").click
      sleep 3

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
