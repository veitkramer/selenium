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

  def test_reminder

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#remove reminder all existing
@driver.get "https://staging.shore.com/merchant/app/reminders"
sleep 3
    @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
sleep 3
    @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
      @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
#new reminder before
@driver.get "https://staging.shore.com/merchant/app/reminders"
sleep 3
@driver.find_element(:css, "button.btn.btn-primary.btn-sm > span:nth-of-type(2)").click
@driver.find_element(:css, "textarea#textfield-1.form-control").clear
sleep 3
@driver.find_element(:css, "textarea#textfield-1.form-control").send_keys "Autoreminder add by Chromedriver"
@driver.find_element(:name, "days").clear
@driver.find_element(:name, "days").send_keys "0"
@driver.find_element(:css, "div > div:nth-of-type(3) > a.form-control > span:nth-of-type(3) > i.shore-icon-backend-filter-down").click
@driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:nth-of-type(2) > a").click

@driver.find_element(:css, "div.flex-cell.flex-spread > div:first-child > div:nth-of-type(2) > input").click
@driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click
sleep 3
#add reminder
@driver.find_element(:css, "td.mtw-column-reminder-text").click
@driver.find_element(:css, "textarea#textfield-2.form-control").clear
sleep 3
@driver.find_element(:css, "textarea#textfield-2.form-control").send_keys "Autoreminder add by Chromedriver added"
@driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click
sleep 3
#remove reminder
@driver.find_element(:css, "button.btn.btn-icon.btn-sm > i").click
@driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
sleep 3
#new reminder before
sleep 3
@driver.get "https://staging.shore.com/merchant/app/reminders"
@driver.find_element(:css, "button.btn.btn-primary.btn-sm > span:nth-of-type(2)").click
sleep 3
@driver.find_element(:css, "textarea#textfield-1.form-control").clear
sleep 3
@driver.find_element(:css, "textarea#textfield-1.form-control").send_keys "Before Reminder from Staging"
@driver.find_element(:name, "days").clear
@driver.find_element(:name, "days").send_keys "0"
@driver.find_element(:css, "div > div:nth-of-type(3) > a.form-control > span:nth-of-type(3) > i.shore-icon-backend-filter-down").click
@driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:nth-of-type(2) > a").click
@driver.find_element(:css, "div.flex-cell.flex-spread > div:first-child > div:nth-of-type(2) > input").click
@driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click
sleep 3
#new reminder after
sleep 3
@driver.find_element(:css, "button.btn.btn-primary.btn-sm > span:nth-of-type(2)").click
sleep 3
@driver.find_element(:css, "textarea#textfield-2.form-control").clear
sleep 3
@driver.find_element(:css, "textarea#textfield-2.form-control").send_keys "After reminder from Staging"
@driver.find_element(:name, "days").clear
@driver.find_element(:name, "days").send_keys "0"
@driver.find_element(:css, "div > div:nth-of-type(3) > a.form-control > span:nth-of-type(3) > i.shore-icon-backend-filter-down").click
@driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:nth-of-type(2) > a").click
@driver.find_element(:css, "div > div:nth-of-type(4) > a.form-control > span:nth-of-type(3) > i.shore-icon-backend-filter-down").click
@driver.find_element(:css, "div.dropdown.open > ul.dropdown-menu > li:nth-of-type(2) > a").click
@driver.find_element(:css, "div.panel-footer.text-right > button.btn.btn-primary").click

@driver.get "https://staging.shore.com/merchant/app/reminders"
verify { assert_include @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(2) > td.mtw-column-reminder-text").text, "Before Reminder from Staging" }
verify { assert_include @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td.mtw-column-reminder-text").text, "After reminder from Staging" }

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
