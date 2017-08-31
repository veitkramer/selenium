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

  def test_message_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 3
#change create meassage
  sleep 5
  @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > a").click
  sleep 2
  @driver.find_element(:css, "#asMain > header > div.as-Header-addActionsContainer > div > a:nth-child(3)").click
  sleep 2

    sleep 2
    @driver.find_element(:css, "div.mmw-contacts-container > div:nth-of-type(2) > table.table.mmw-contacts-table > tbody.mmw-table-body.mmw-table-list > tr:nth-of-type(1) > td:nth-of-type(2)").click
    sleep 2
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "was geht hier ab?"
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 3
    assert(@driver.find_element(:css => "div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text.include?("was geht hier ab?"),"Assertion Pass")
#create message via customer details
    @driver.get "https://app-shell-staging.shore.com/customers"
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").clear
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Tiger"
    sleep 3
    @driver.find_element(:css, "#asMain > div.as-App > div > shore-app-wrapper > div > div > div > div > div.mtw-grid-content > table > tbody > tr").click
    sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-new-message").click
    sleep 2
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "Wo hast du deine Brille hin?"
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 3
    assert(@driver.find_element(:css => "div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text.include?("was geht hier ab?"),"Assertion Pass")
    sleep 4


  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
