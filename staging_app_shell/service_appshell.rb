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

  def test_service_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#creates a new service
@driver.get "https://staging.shore.com/merchant/bookings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
sleep 2
    checkbox = @driver.find_element(:css, "#serviceStepsCheckbox");
        if checkbox.selected?
          @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          else
            checkbox.click
            @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            end
    sleep 2
    @driver.get "https://staging.shore.com/merchant/services?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    @driver.find_element(:css, "a.btn.btn-orange.launch-service-popup").click
    sleep 2
    @driver.find_element(:css, "input#service_name.form-control").send_keys "Autotest"
    @driver.find_element(:css, "input#service_price.form-control.text-right").send_keys "99"
    @driver.find_element(:css, "textarea#service_description.form-control").send_keys "This is cool"
    @driver.find_element(:css, "div.form-horizontal.tile-content > div:nth-of-type(3) > div > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:first-child > div > div.tax-category-list > span:first-child").click
    @driver.find_element(:css, "div.form-horizontal.tile-content > div:nth-of-type(4) > div > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(3) > input.form-control.service-step-name").send_keys "Chromedriver"
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(4) > div.input-group > input.form-control.service-step-duration-hours").clear
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(4) > div.input-group > input.form-control.service-step-duration-hours").send_keys "1"
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(5) > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "#new_service > div.tile-footer > input").click
    sleep 5
#delete service
    @driver.find_element(:css, "[id^=\"service_\"] > div.span2.duration > span").click
    @driver.switch_to.alert.accept
    sleep 4
#create a ococcurring service
    @driver.find_element(:css, "a.btn.btn-orange.launch-occurring-service-popup").click
    sleep 2
    @driver.find_element(:css, "input#occurring_service_name.form-control").send_keys "Autotest"
    @driver.find_element(:css, "input#occurring_service_price.form-control.text-right").send_keys "99"
    @driver.find_element(:css, "textarea#occurring_service_description.form-control").send_keys "This is cool"
    @driver.find_element(:css, "#select2-chosen-1").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "#select2-chosen-3").click
    @driver.find_element(:css, "ul > li:nth-of-type(2) > div").click
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(3) > input.form-control.service-step-name").send_keys "Chromedriver"
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(4) > div.input-group > input.form-control.service-step-duration-hours").clear
    @driver.find_element(:css, "div.auto-row-container.ui-sortable > div:nth-of-type(1) > div.row > div:nth-of-type(4) > div.input-group > input.form-control.service-step-duration-hours").send_keys "1"
    @driver.find_element(:css, "#select2-chosen-4").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "span.simplecolorpicker.inline.fontawesome > span:nth-of-type(2)").click
    @driver.find_element(:css, "#occurring_service_max_capacity").send_keys "20"
    @driver.find_element(:css, "input.form-control.datepicker.appointment-group-date").click
    @driver.find_element(:css, "tbody > tr:nth-of-type(4) > td:nth-of-type(4) > a.ui-state-default").click
    @driver.find_element(:css, "#new_occurring_service > div.tile-footer > input").click
    sleep 5
#delete ococcurring service
    @driver.find_element(:css, "[id^=\"occurring_service_\"] > div.span2.duration > span").click
    @driver.switch_to.alert.accept
    sleep 4

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
