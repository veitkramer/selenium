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

  def test_create_appt_steps_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 2
    @driver.get "https://staging.shore.com/merchant/bookings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    sleep 3
    checkbox = @driver.find_element(:css, "#serviceStepsCheckbox");
      if checkbox.selected?
         @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
      else checkbox.click
      end
    @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 2
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 7
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > div > a:nth-child(1)").click
    sleep 2
    @driver.find_element(:css, "ul.nav.nav-tabs > li:nth-of-type(2) > button").click
    sleep 2
    @driver.find_element(:css, "#asMain > div.as-Overlay.is-visible > div > div > div.tabs-container > ul > li:nth-child(1)").click
    sleep 2
    @driver.find_element(:css, "#asMain > div.as-Overlay.is-visible > div > div > div.tabs-container > ul > li:nth-child(2)").click
    sleep 2
    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(1) > div.row > div.text-primary.text-truncate").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    sleep 2
    @driver.find_element(:class, "select2-search-field").click
    sleep 1
    #@driver.find_element(:class, "select2-search-field").send_keys "Waschen, Schneiden"
    sleep 1
    @driver.action.send_keys(:enter).perform
    sleep 2
    verify { assert_equal "ARBEITSSCHRITTE", @driver.find_element(:css, "div.panel-body > fieldset:nth-of-type(1) > legend > span").text }
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 2

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
