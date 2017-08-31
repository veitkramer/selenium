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

  def test_permission_admin

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "[STAGING] Shore - Manage your customers", @driver.title }


    @driver.get "https://staging.shore.com/merchant/appointments/weekly"
    @driver.get "https://staging.shore.com/merchant/app/staff"
    verify { assert_include @driver.find_element(:css, "th.mtw-header-column.mtw-header-name").text, "NAME" }
    verify { assert_include @driver.find_element(:css, "span._3lIP0JzD_STHsYobzymLVM").text, "Neuer Mitarbeiter" }
    verify { assert_include @driver.find_element(:css, "span.active").text, "Aktiv" }
    @driver.find_element(:id, "btnCloseMainNav").click
    @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div._416I3Vf9gcW6n1CqOnjSQ > ul > li:nth-child(2) > span").click

    sleep 5
    pos1 = @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div.l0ZE8zGkDBbOIJFOHP50d > div > div.mtw-grid-content > table > tbody > tr:nth-child(1) > td:nth-child(1) > i");
    pos2 = @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(3) > td:nth-of-type(2)");
    @driver.action.drag_and_drop(pos1, pos2).perform
    sleep 3




  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
