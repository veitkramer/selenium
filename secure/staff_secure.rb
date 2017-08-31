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

  def test_create_staff

#login on secure with test account
    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    @driver.get "https://secure.shore.com"
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
#creates a new staff member
    @driver.get "https://my.shore.com/calendar/week#/launchpad"
    sleep 3
    @driver.get "https://my.shore.com/hr"
    sleep 3
    @driver.find_element(:css, "a.btn.btn-primary > span").click
    sleep 2
    @driver.find_element(:id, "textfield-1").clear
    @driver.find_element(:id, "textfield-1").send_keys "Auto"
    sleep 2
    @driver.find_element(:id, "textfield-2").clear
    @driver.find_element(:id, "textfield-2").send_keys "A Chromedriver"
    sleep 2
    @driver.find_element(:id, "textfield-3").clear
    @driver.find_element(:id, "textfield-3").send_keys "auto_test@shore.com"
    sleep 2
    @driver.find_element(:id, "textfield-4").clear
    @driver.find_element(:id, "textfield-4").send_keys "01742499385"
    sleep 2
    @driver.find_element(:css, "div.Select.Select--multi.is-searchable.has-value > div.Select-control").click
    @driver.action.send_keys(:backspace).perform
    sleep 2
    @driver.find_element(:css, "div.Select-input > input").send_keys "Testmerchant # QA"
    @driver.action.send_keys(:enter).perform
    sleep 4
    @driver.find_element(:css, "div.checkbox.checkbox-slider--b-flat").click
    sleep 4
    @driver.find_element(:css, "section.panel-footer > button:nth-of-type(2)").click
    sleep 4
#edit staff member
    @driver.navigate().refresh()
    @driver.find_element(:id, "textfield-3").click
    sleep 2
    @driver.find_element(:id, "textfield-3").clear
    @driver.find_element(:id, "textfield-3").send_keys "11.11.1999"
    @driver.action.send_keys(:enter).perform
    sleep 4
    @driver.find_element(:css, "section.panel-body > div:nth-of-type(4) > div.flex-cell.flex-spread > div.isViewMode > div").click
    sleep 2
    @driver.find_element(:id, "textfield-5").send_keys "Driverroad 10"
    @driver.find_element(:id, "textfield-6").send_keys "90000"
    @driver.find_element(:id, "textfield-7").send_keys "Minga"
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "ul > li:nth-of-type(8)").click
    @driver.action.send_keys(:enter).perform
    sleep 3
#change branch
    @driver.find_element(:css, "section.panel-body > div:nth-of-type(6) > div.flex-cell.flex-spread > div.isViewMode > div > div > div").click
    @driver.action.send_keys(:backspace).perform
    @driver.find_element(:css, "div.Select.Select--multi.is-searchable > div.Select-control > div.Select-placeholder").click
    @driver.find_element(:css, "div.Select-menu-outer > div.Select-menu > div:nth-of-type(2) > span.Select-new > span").click
    @driver.action.send_keys(:enter).perform
#account login
    @driver.find_element(:css, "section.panel-body > div:nth-of-type(2) > div.checkbox.checkbox-slider--b-flat > label > span").click
    @driver.action.send_keys(:enter).perform
    sleep 2
#service
    @driver.find_element(:id, "check-all-services").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:first-child > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(2) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(3) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(4) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(5) > input").click
    @driver.action.send_keys(:enter).perform
#booking times
    sleep 2
    @driver.find_element(:css, "div#asMain section > div > label > span").click
    @driver.find_element(:css, "div#asMain div.Select-placeholder").click
    @driver.find_element(:css, "div.Select-menu-outer > div.Select-menu > div:nth-of-type(2) > span.Select-new > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(6) > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(5) > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(4) > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.row > div > div.form-group > input:nth-of-type(1)").click
    @driver.find_element(:css, "div.form-group > div:nth-of-type(1) > ul.ui-timepicker-list > li:nth-of-type(145)").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.row > div > div.form-group > input:nth-of-type(2)").click
    @driver.find_element(:css, "div.form-group > div:nth-of-type(2) > ul.ui-timepicker-list > li:nth-of-type(156)").click
    @driver.action.send_keys(:enter).perform
#delete staff member via staff details page
    sleep 5
    @driver.find_element(:css, "button.btn.btn-icon.pull-right > i").click
    sleep 2
    @driver.find_element(:css, "body > div.ReactModalPortal > div > div > section > section.panel-footer > button.btn.btn-danger").click
    sleep 3
    end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
