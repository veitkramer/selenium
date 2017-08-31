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

  def test_reminder

    @driver.get "https://secure.shore.com/merchant/sign_in"
    sleep 1
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    @driver.get "https://secure.shore.com"
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
    @driver.get "https://my.shore.com/calendar/week#/launchpad"
    sleep 5
    @driver.get "https://my.shore.com/reminders"
#remove exisiting reminder
    sleep 2
    if @driver.find_elements(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").size() > 0
      @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
    end

    if @driver.find_elements(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").size() > 0
      @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
    end
#add before reminder
    sleep 3
    @driver.find_element(:css, "button.btn.btn-primary.btn-sm > span:nth-of-type(2)").click
    @driver.find_element(:css, "textarea#textfield-1.form-control").clear
    sleep 3
    @driver.find_element(:css, "textarea#textfield-1.form-control").send_keys "Before Autoreminder add by Chromedriver"
    @driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click
    sleep 3
#add after reminder
    @driver.find_element(:css, "button.btn.btn-primary.btn-sm > span:nth-of-type(2)").click
    @driver.find_element(:css, "textarea#textfield-2.form-control").clear
    sleep 3
    @driver.find_element(:css, "textarea#textfield-2.form-control").send_keys "After Autoreminder add by Chromedriver"
    @driver.find_element(:css, "div > div:nth-of-type(4) > a.form-control > span:first-child").click
    @driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:nth-of-type(2) > a").click
    @driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click
    sleep 3
#check if reminders are existing
    verify {assert_equal @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td.mtw-column-reminder-text").text, "Before Autoreminder add by Chromedriver"}
    verify {assert_equal @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(2) > td.mtw-column-reminder-text").text, "After Autoreminder add by Chromedriver"}
    sleep 3
#remove reminder
    @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
    sleep 2
    @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
    sleep 3

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
