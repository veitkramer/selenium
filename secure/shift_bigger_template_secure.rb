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

  def test_shift
#login
    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
#create shift
    @driver.get "https://my.shore.com/shiftplan"
    #@driver.find_element(:id, "spBtnCreateShift").click
    sleep 4
    @driver.find_element(:css, "div#spMainContainer tbody > tr > th").click
    sleep 4
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(2) > span").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(3) > span").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(4) > span").click
    sleep 2
    @driver.find_element(:name, "startTime").click
    sleep 2
    @driver.find_element(:css, "div.ui-timepicker-wrapper > ul.ui-timepicker-list > li:nth-of-type(41)").click
    sleep 2
    @driver.find_element(:name, "endTime").click
    sleep 2
    @driver.find_element(:css, "div.ui-timepicker-wrapper > ul.ui-timepicker-list > li:nth-of-type(36)").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#delete shift
    @driver.find_element(:css, "div#spMainContainer tbody > tr > th").click
    sleep 2
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#create template
    sleep 5
    @driver.find_element(:id, "spBtnCreateTemplate").click
    sleep 2
    @driver.find_element(:css, "#mspw-tpl-name").send_keys "Autotemplate"
    sleep 2
#first line
    @driver.find_element(:css, "div#spMain div:nth-child(2) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(1)").click
    @driver.find_element(:css, "div#spMain div:nth-child(2) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(2) > span").click
    @driver.find_element(:css, "div#spMain div:nth-child(2) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(3) > span").click
    @driver.find_element(:css, "div#spMain div:nth-child(2) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"endTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper > ul.ui-timepicker-list > li:nth-of-type(4)").click
    sleep 2
#second line
    @driver.find_element(:css, "div#spMain div:nth-child(3) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(2)").click
    @driver.find_element(:css, "div#spMain div:nth-child(3) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(3)").click
    @driver.find_element(:css, "div#spMain div:nth-child(3) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(4)").click
    sleep 2
    @driver.find_element(:css, "div#spMain div:nth-child(3) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"startTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(49)").click
    @driver.find_element(:css, "div#spMain div:nth-child(3) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"endTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(8)").click
    sleep 2
#third line
    @driver.find_element(:css, "div#spMain div:nth-child(4) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(3)").click
    @driver.find_element(:css, "div#spMain div:nth-child(4) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(4)").click
    @driver.find_element(:css, "div#spMain div:nth-child(4) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(5)").click
    sleep 2
    @driver.find_element(:css, "div#spMain div:nth-child(4) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"startTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(65)").click
#fourth line
    @driver.find_element(:css, "div#spMain div:nth-child(5) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(5)").click
    @driver.find_element(:css, "div#spMain div:nth-child(5) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(6)").click
    @driver.find_element(:css, "div#spMain div:nth-child(5) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(7)").click
    sleep 2
    @driver.find_element(:css, "div#spMain div:nth-child(5) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"endTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(52)").click
    @driver.find_element(:css, "div#spMain div:nth-child(5) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"startTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(81)").click
#fifth line
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(1)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(2)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(3)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(4)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(5)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(6)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.flex-row > div > label:nth-child(7)").click
    sleep 2
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"endTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(59)").click
    @driver.find_element(:css, "div#spMain div:nth-child(6) > div > div.flex-cell.flex-spread > div.row > div:nth-child(1) > div > input[name=\"startTime\"]").click
    @driver.find_element(:css, "div.ui-timepicker-wrapper.ui-timepicker-positioned-top > ul.ui-timepicker-list > li:nth-of-type(89)").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#load template
    @driver.find_element(:id, "spBtnLoadTemplate").click
    sleep 3
    @driver.find_element(:id, "mspw-resource-selector").click
    sleep 3
    @driver.find_element(:id, "mspw-resource-selector").send_keys "Marshell Eriksen (OW)"
    sleep 2
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "#mspw-tpl-selector").click
    sleep 2
    @driver.find_element(:css, "#mspw-tpl-selector > option:nth-child(2)").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
#delete shift
    sleep 10
    @driver.find_element(:css, "div#spMainContainer tbody > tr > th").click
    sleep 2
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 1
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 1
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 1
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 1
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.mspw-rule-right-col > a.btn.btn-icon > i").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 10
#delete template
    @driver.find_element(:id, "spBtnLoadTemplate").click
    sleep 2
    @driver.find_element(:id, "mspw-tpl-selector").click
    sleep 2
    @driver.find_element(:css, "#mspw-tpl-selector > option:nth-child(2)").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-delete.btn-default").click
    sleep 2
    @driver.find_element(:css, "button.btn.btn-delete.btn-danger").click
    sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-delete").click
    sleep 3

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
