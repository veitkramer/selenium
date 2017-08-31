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

  def test_create_customer

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#creates a new customer / delete the customer afterwards
      @driver.find_element(:css, "i.shore-icon-backend-new-customer").click
      @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div > div > div.customers-app--1n26yqc8E4W14AyFhyH_wj.panel-heading > div > div > div.flex-cell.flex-spread > div > div:nth-child(1) > div > div > a > span.customers-app--3dE172rI_1mUEgGr6c1w0W > i").click
      @driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:first-child > a").click
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
      @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-8.col-lg-8 > div:nth-child(2) > div:nth-child(1) > div.customers-app--1_BbJF2bJfOvEfjYoTembg.customers-app--ccWgGgLlsk4LAV4R5jrJ3 > div > div.flex-cell.flex-spread > div > div.flex-cell.flex-spread > div > div > div.customers-app--1j4MRJEh133sJNdIys8XQo > ul > li > input").click
      @driver.find_element(:css, "ul > li:nth-of-type(2) > span > span:nth-of-type(3)").click
      @driver.find_element(:css, "div.flex-cell.button-cell > button.btn.btn-primary").click
      @driver.find_element(:css, "div.flex-cell.flex-spread > input.form-control").send_keys "Auto note written by chrome"
      @driver.find_element(:css, "form.flex-form-inline > div:nth-of-type(2) > button.btn.btn-primary").click
      sleep 4

#delete customer
      @driver.get "https://staging.shore.com/merchant/app/customers"
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").clear
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Auto"
      sleep 4
      @driver.find_element(:css, "span.mtw-column-action-delete-row").click
      sleep 2
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm.mtw-column-confirm-action-delete-row").click

#search for customer in column
      @driver.get "https://staging.shore.com/merchant/app/customers"
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Alisson"
      sleep 5
      @driver.find_element(:css, "tr.mtw-row.can-open > td:nth-of-type(2)").click
      sleep 2
      verify { assert_include @driver.find_element(:css, "h2 > span:first-child").text, "Alisson" }
      @driver.find_element(:css,"i.shore-icon-backend-previous").click
      @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-lastname > input").send_keys "Travis"
      sleep 5
      @driver.find_element(:css, "tr.mtw-row.can-open > td:nth-of-type(2)").click
      sleep 2
      verify { assert_include @driver.find_element(:css, "h2 > span:nth-of-type(3)").text, "Travis" }
      @driver.find_element(:css,"i.shore-icon-backend-previous").click
      sleep 2







  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
