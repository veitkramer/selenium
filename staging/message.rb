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

  def test_message

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#change create meassage
    @driver.find_element(:css, "body > header > div > div.header-account > div.creation-container.bootstrap3 > a.btn.btn-icon.launch-conversation-creation > i").click
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.mmw-merchant-app-wrapper.fetched-initial-data > div.mmw-list-container > div > div.mmw-collapse > div > div.mmw-search-bar-container > form > div > input").send_keys "Tiger"
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.mmw-merchant-app-wrapper.fetched-initial-data > div.mmw-list-container > div > div.mmw-collapse > div > div.mmw-contacts-container.is-active > div.mmw-contacts-table-container.active > div > table > tbody > tr > td:nth-child(2)").click
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.mmw-merchant-app-wrapper.fetched-initial-data > div.mmw-conversation-container > div > div.mmw-collapse > div.mmw-fetched-messages-coontainer > div.panel-footer.mmw-input-bar > form > div > div.mmw-cell.mmw-text-input-cell > input").send_keys "bist am Start?"
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 3
    verify { assert_include @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.mmw-merchant-app-wrapper.fetched-initial-data > div.mmw-conversation-container > div > div.mmw-collapse > div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text, "bist am Start?" }
    sleep 3
#create message via customer details
    @driver.get "https://staging.shore.com/merchant/app/customers"
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").clear
    @driver.find_element(:css, "th.mtw-filter-column.mtw-filter-firstname > input").send_keys "Tiger"
    sleep 2
    @driver.find_element(:css, "div#MerchantAppContainer td:nth-child(2) > span").click
    sleep 2
    @driver.find_element(:css, "div#MerchantAppContainer span:nth-child(3) > button[type=\"button\"] > i").click
    sleep 2
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "was geht hier ab?"
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
