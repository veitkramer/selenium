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

  def test_create_staff

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login on staging with test account
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#creates a new staff member
    @driver.get "https://staging.shore.com/merchant/app/staff"
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-header > div._1e5oOWRxQhfr6znZlP6-p5 > a > span").click
    sleep 4
    @driver.find_element(:id, "textfield-1").clear
    @driver.find_element(:id, "textfield-1").send_keys "Auto"
    sleep 4
    @driver.find_element(:id, "textfield-2").clear
    @driver.find_element(:id, "textfield-2").send_keys "A Chromedriver"
    sleep 4
    @driver.find_element(:id, "textfield-3").clear
    @driver.find_element(:id, "textfield-3").send_keys "auto_test@shore.com"
    sleep 4
    @driver.find_element(:id, "textfield-4").clear
    @driver.find_element(:id, "textfield-4").send_keys "01742499385"
    sleep 4
    @driver.find_element(:css, "div.Select.Select--multi.is-searchable.has-value > div.Select-control").click
    @driver.action.send_keys(:backspace).perform
    @driver.find_element(:css, "div.Select-input > input").send_keys "Endeavourdude"
    @driver.action.send_keys(:enter).perform
    sleep 4
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div > form > section > section.panel-body > div._2qerZxZ364zWppAduqbypy > section > section.panel-body > div.checkbox.checkbox-slider--b-flat > label").click
    sleep 4
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div > form > section > section.panel-footer._1By3kMWilonk1XYy_gE9ir > button:nth-child(2)").click
    sleep 4
#add staff member
    @driver.get "https://staging.shore.com/merchant/app/staff"
    @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(2)").click
    sleep 2
    @driver.find_element(:id, "textfield-3").clear
    @driver.find_element(:id, "textfield-3").send_keys "11.11.1999"
    @driver.action.send_keys(:enter).perform
    sleep 2
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-7.col-lg-7 > form.n5NxnAuYKX6p3hbpBVcR6 > section > section.panel-body > div.flex-row._3kxuBqb7gWbFoZmCIEhzvB > div.flex-cell.flex-spread._1ugUZWJ0HCziEBesa1Z3r1 > div > div > i").click
    @driver.find_element(:id, "textfield-5").send_keys "Driverroad 10"
    @driver.find_element(:id, "textfield-6").send_keys "90000"
    @driver.find_element(:id, "textfield-7").send_keys "Minga"
    sleep 2
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-7.col-lg-7 > form.n5NxnAuYKX6p3hbpBVcR6 > section > section.panel-footer.text-right > button").click
    sleep 2
#account login
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-7.col-lg-7 > form:nth-child(2) > section > section.panel-body > section > section.panel-body > div > div > div:nth-child(2) > div:nth-child(1) > div > div > span > span").click
    @driver.find_element(:css, "div.Select-menu-outer > div.Select-menu > div:nth-of-type(2) > span.Select-new > span").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-7.col-lg-7 > form:nth-child(2) > section > section.panel-footer.text-right > button").click
    sleep 2
#service
    @driver.find_element(:id, "check-all-services").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(1) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(2) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(3) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(4) > input").click
    @driver.find_element(:css, "div > div:first-child > div:nth-of-type(2) > div:nth-of-type(5) > input").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-5.col-lg-5 > form:nth-child(1) > section > section.panel-footer.text-right > button").click
    sleep 2
#booking times
    @driver.find_element(:css, "section.panel-body > section:first-child > div > div.Select.has-value > div.Select-control > div.Select-placeholder").click
    @driver.find_element(:css, "div.Select-menu-outer > div.Select-menu > div:nth-of-type(2) > span.Select-new > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(6) > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(5) > span").click
    @driver.find_element(:css, "fieldset.form-inline > div:first-child > div.flex-row > div.flex-cell.flex-spread > div.flex-row > div.btn-inputs > label:nth-of-type(4) > span").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-5.col-lg-5 > form:nth-child(2) > section > section.panel-body > section.panel-body-padding.scrollable > div > fieldset > div:nth-child(1) > div > div.flex-cell.flex-spread > div.row > div > div > input:nth-child(4)").click
    @driver.find_element(:css, "ul.ui-timepicker-list > li:nth-of-type(132)").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-5.col-lg-5 > form:nth-child(2) > section > section.panel-footer.text-right > button").click
#change branch
    @driver.find_element(:css, "section.panel-body > div:nth-of-type(6) > div.flex-cell.flex-spread > div.isViewMode > div > i.shore-icon-backend-edit").click
    @driver.action.send_keys(:backspace).perform
    @driver.find_element(:css, "div.Select.Select--multi.is-searchable > div.Select-control > div.Select-placeholder").click
    @driver.find_element(:css, "div.Select-menu-outer > div.Select-menu > div:first-child > span.Select-new > span").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.col-xs-12.col-sm-12.col-md-7.col-lg-7 > form.n5NxnAuYKX6p3hbpBVcR6 > section > section.panel-footer.text-right > button").click
#delete staff member
    @driver.get "https://staging.shore.com/merchant/app/staff"
    @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(7) > div.mtw-column-actions > span.mtw-column-action-delete-row").click
    @driver.find_element(:css, "body > div.ReactModalPortal > div > div > section > section.panel-footer > button.btn.btn-danger").click

  sleep 3


    end



  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
