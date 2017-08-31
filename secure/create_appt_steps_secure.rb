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

  def test_create_appt_steps

    @driver.get "https://my.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "Shore - Manage your customers", @driver.title }

    @driver.get "https://secure.shore.com/merchant/bookings?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
    sleep 3
      checkbox = @driver.find_element(:css, "#serviceStepsCheckbox");
      if checkbox.selected?
        @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
      else checkbox.click
      end
    @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 2
    @driver.get "https://my.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:css, "div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "div.as-Header-addActions > a:first-child").click
    sleep 2
    @driver.find_element(:css, "ul.nav.nav-tabs > li:nth-of-type(2) > button").click
    sleep 2
    @driver.find_element(:css, "input.form-control.customer-summary-input").send_keys "Abel Joyce"
    sleep 1
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "input[name=\"subject\"]").clear
    @driver.find_element(:css, "input[name=\"subject\"]").send_keys "Automatic generated"
    @driver.find_element(:css, "div.form-group > div > div.has-feedback > div > ul > li > input").click
    @driver.action.send_keys(:enter).perform
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 2

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
