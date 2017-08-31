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

  def test_searching

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

    #test search
    @driver.find_element(:css, "#searchInput").send_keys "Scheissnewand"
    sleep 2
    verify { assert_equal "Es wurde bei dieser Suchanfrage leider nichts gefunden!", @driver.find_element(:css, "#search2-modal-portal > div > div > div > div > div > div:nth-child(1) > b").text }
    sleep 2
    @driver.find_element(:css, "#searchInput").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "a > div:nth-of-type(2) > div").click
    sleep 2
    verify { assert_equal "E-Mail", @driver.find_element(:css, "div.panel-body > div:first-child > div.flex-row > div.flex-cell.flex-spread.row-data > div > div > label.control-label > span:first-child").text }
    @driver.find_element(:css, "#searchInput").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "#search2-modal-portal > div > div > div > div > div.yqXErLhpudpgwonrEvEXg > div > div > div > div._2T5rEwoADOfXBF7EfxFohN > a:nth-child(1) > i").click
    sleep 2
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div > div.tabs-component-container.tabs-at-left.tabs-dir-ltr > div.tabs-panels-container > div.tab-content.center-block.show > div > div > div > div > div.panel.panel-overlay > div.body-container.maw-create-widget > div > form > div.panel-footer.text-right > button").click
    sleep 2
    @driver.find_element(:css, "#searchInput").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "div > div:nth-of-type(4) > a:nth-of-type(2) > i.shore-icon-backend-new-message").click
    sleep 2
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.fetched-initial-data > div.mmw-conversation-container > div > div.mmw-collapse > div:nth-child(2) > div.panel-footer.mmw-input-bar > form > div > div.mmw-cell.mmw-text-input-cell > input").send_keys "Was geht ab?"
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.fetched-initial-data > div.mmw-conversation-container > div > div.mmw-collapse > div:nth-child(2) > div.panel-footer.mmw-input-bar > form > div > div.mmw-cell.mmw-text-input-button > button").click
    sleep 4
    @driver.find_element(:css, "#widgetManagerContainer > div > div > div.merchant-messenger-widget-container.mmw-container.fetched-initial-data > div.mmw-conversation-container > div > div.panel-heading > button > i").click
    sleep 2

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
