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

  def test_create_appt_steps

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click


    @driver.get "https://staging.shore.com/merchant/bookings"
    sleep 3
            checkbox = @driver.find_element(:css, "#serviceStepsCheckbox");
            if checkbox.selected?
               @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            else checkbox.click
            end
          @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click
    sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-service-step-event").click

    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(1) > div.row > div.text-primary.text-truncate").click
    sleep 2

    @driver.find_element(:css, "#widgetManagerContainer > div > div > div > div.tabs-component-container.tabs-at-left.tabs-dir-ltr > div.tabs-panels-container > div.tab-content.center-block.show > div > div > div > div > div.panel.panel-overlay > div.body-container.maw-create-widget > div > form > div.panel-body > div:nth-child(2) > div > input").clear
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div > div.tabs-component-container.tabs-at-left.tabs-dir-ltr > div.tabs-panels-container > div.tab-content.center-block.show > div > div > div > div > div.panel.panel-overlay > div.body-container.maw-create-widget > div > form > div.panel-body > div:nth-child(2) > div > input").send_keys "Automatic generated"
    sleep 2
    @driver.find_element(:id, "s2id_autogen18").send_keys "Waschen, Schneiden"
    @driver.action.send_keys(:enter).perform
    sleep 2
    verify { assert_equal "Arbeitsschritt", @driver.find_element(:css, "div.service-steps.ui-sortable > div:nth-of-type(1) > div.form-control-append.col-step-type > div > a > span:nth-of-type(1)").text }
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
