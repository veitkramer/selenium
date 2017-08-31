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

  def test_create_recurring_appt_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

    @driver.get "https://staging.shore.com/merchant/bookings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"
    sleep 3
            checkbox = @driver.find_element(:css, "input#serviceStepsCheckbox");
            if checkbox.selected?
              checkbox.click
            else
              @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            end
          @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          sleep 2
          @driver.get "https://app-shell-staging.shore.com/calendar/week"
          sleep 5
#recurring week end after x appt
    sleep 5
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > div > a:nth-child(1)").click

    sleep 2
    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(1)").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "div#asMain div:nth-child(3) > div:nth-child(2) > div > input:nth-child(1)").click
    sleep 3
    @driver.find_element(:name, "showReccurrence").click
    sleep 3
    @driver.find_element(:id, "recurrence-interval").clear
    @driver.find_element(:id, "recurrence-interval").send_keys "2"
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(2) > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:nth-of-type(2) > div").click
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(3) > div > a > span:nth-of-type(2)").click
    @driver.find_element(:css, "ul > li:nth-of-type(2) > div").click
    @driver.find_element(:id, "recurrence-count").clear
    @driver.find_element(:id, "recurrence-count").send_keys "6"
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 2
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(4) > div > div.has-feedback > div > ul > li > input").send_keys "Silent"
    @driver.action.send_keys(:enter).perform
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(5) > div > div.has-feedback > div > ul > li > input").send_keys "James"
    @driver.action.send_keys(:enter).perform
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
#recurring month never ending
    sleep 5
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > div > a:nth-child(1)").click

    sleep 2
    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(3)").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "div#asMain div:nth-child(3) > div:nth-child(2) > div > input:nth-child(1)").click
    sleep 3
    @driver.find_element(:name, "showReccurrence").click
    sleep 3
    @driver.find_element(:id, "recurrence-interval").clear
    @driver.find_element(:id, "recurrence-interval").send_keys "2"
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(2) > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:nth-of-type(3) > div").click
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(3) > div > a > span:nth-of-type(2)").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "button.btn.btn-primary").click
    sleep 2
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(4) > div > div.has-feedback > div > ul > li > input").send_keys "Silent"
    @driver.action.send_keys(:enter).perform
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(5) > div > div.has-feedback > div > ul > li > input").send_keys "James"
    @driver.action.send_keys(:enter).perform
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary").click
#recurring day ends on date
    sleep 5
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > a").click
    sleep 2
    @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > div > a:nth-child(1)").click
    sleep 3
    @driver.find_element(:name, "customerSummary").click
    sleep 2
    @driver.find_element(:css, "div.list-group.search-results > a:nth-of-type(2)").click
    sleep 2
    @driver.find_element(:name, "subject").clear
    @driver.find_element(:name, "subject").send_keys "Automatic generated"
    @driver.find_element(:css, "div#asMain div:nth-child(3) > div:nth-child(2) > div > input:nth-child(1)").click
    sleep 3
    @driver.find_element(:name, "showReccurrence").click
    sleep 3
    @driver.find_element(:id, "recurrence-interval").clear
    @driver.find_element(:id, "recurrence-interval").send_keys "2"
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(2) > div > a > span:nth-of-type(1)").click
    @driver.find_element(:css, "ul > li:first-child > div").click
    @driver.find_element(:css, "div.form-group.row > div:nth-of-type(3) > div > a > span:nth-of-type(2)").click
    @driver.find_element(:css, "ul > li:nth-of-type(3) > div").click
    @driver.find_element(:id, "recurrence-ends-at").clear
    @driver.find_element(:id, "recurrence-ends-at").send_keys "11.11.2020"
    @driver.action.send_keys(:enter).perform
    sleep 2
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(4) > div > div.has-feedback > div > ul > li > input").send_keys "Silent"
    @driver.action.send_keys(:enter).perform
    sleep 2
    @driver.find_element(:css, "div.panel-body > div:nth-of-type(5) > div > div.has-feedback > div > ul > li > input").send_keys "James"
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.action.send_keys(:enter).perform

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
