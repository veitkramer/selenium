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

  def test_shift

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#create shift
    @driver.get "https://staging.shore.com/merchant/shiftplan"
    @driver.find_element(:css, "a.btn.btn-orange.btn-new-shift").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:first-child > span").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(2) > span").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(3)").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(4) > span").click
    sleep 2
    @driver.find_element(:css, "div.wm-align-br.wm-container > div:first-child > div.merchant-shiftplan-rules-widget-container > div.panel > div.panel-body > div > fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.flex-spread > div.row > div:first-child > div.form-group.mspw-time-picker > input:nth-of-type(1)").click
    @driver.find_element(:css, "fieldset.form-inline > div:nth-of-type(1) > div.flex-row > div.flex-cell.flex-spread > div.row > div:first-child > div.form-group.mspw-time-picker > input:nth-of-type(1)").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 2
#delete shift
    @driver.find_element(:css, "tbody > tr:first-child > td:nth-of-type(1) > div.label").click
    @driver.find_element(:css, "i.shore-icon-backend-delete-02").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#create template
    @driver.find_element(:css, "a.btn.btn-orange.btn-new-shift-template").click
    sleep 3
    @driver.find_element(:css, "input#mspw-tpl-name.form-control").send_keys "Autotemplate"
    @driver.find_element(:css, "label.btn.btn-default.btn-sm").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(2) > span").click
    @driver.find_element(:css, "div.mspw-weekday-picker.btn-inputs > label:nth-of-type(3) > span").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#load template
    @driver.find_element(:css, "a.btn.btn-orange.btn-load-shift-template").click
    @driver.find_element(:css, "li.editTag > div").click
    @driver.find_element(:id, "mspw-resource-selector").send_keys "Ted"
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "#mspw-tpl-selector").click
    @driver.find_element(:css, "#mspw-tpl-selector > option:nth-child(2)").click
    @driver.find_element(:css, "div.flex-item.toggle-button-container > button.btn.btn-default").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#delete shift
    @driver.find_element(:css, "div.label").click
    @driver.find_element(:css, "i.shore-icon-backend-delete-02").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 5
#delete template
    @driver.find_element(:css, "a.btn.btn-orange.btn-load-shift-template").click
    @driver.find_element(:css, "li.editTag > div").click
    @driver.find_element(:css, "#mspw-tpl-selector > option:nth-child(2)").click
    @driver.find_element(:css, "button.btn.btn-delete.btn-default").click
    @driver.find_element(:css, "button.btn.btn-delete.btn-danger").click
    sleep 2
#check availability with shift
    @driver.get "https://staging.shore.com/merchant/bookings"
    checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_shiftplan_availability")
      if checkbox.selected?
        @driver.find_element(:css, "div.shiftplan-availability.shiftplan-availability-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
      else
        checkbox.click
      end
        @driver.find_element(:css, "div.shiftplan-availability.shiftplan-availability-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click

        @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
        @driver.find_element(:css, "div.items > div:nth-of-type(1) > div.item-group-title").click
        sleep 4
        @driver.find_element(:css, "div.item-group.expanded > div:nth-of-type(2) > div.item-content > div.item-content-left").click
        sleep 4
        @driver.find_element(:css, "button.widget-button.services-submit-button").click
        sleep 4
        @driver.find_element(:css, "div.item-content.with-icons > div.item-content-left > div.item-name").click
        sleep 4
        @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
        sleep 4
        verify { assert_equal "Diese Woche stehen leider keine online buchbaren Termine mehr zur Verfügung.", @driver.find_element(:css, "div.text-muted > span").text }

        @driver.get "https://staging.shore.com/merchant/bookings"
        checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_shiftplan_availability")
          if checkbox.selected?
            checkbox.click
          else
            @driver.find_element(:css, "div.shiftplan-availability.shiftplan-availability-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          end
            @driver.find_element(:css, "div.shiftplan-availability.shiftplan-availability-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click


sleep 2



  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
