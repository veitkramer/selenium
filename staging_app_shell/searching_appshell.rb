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

  def test_searching_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 2
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
#search with no result
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Scheissnewand"
    sleep 2
    verify { assert_equal "Es wurde bei dieser Suchanfrage leider nichts gefunden!", @driver.find_element(:css, "#asMain > div.as-Overlay.is-visible > div > div > div > div > div > div:nth-child(1) > b").text }
    sleep 2
#search with result and go to customer page
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "#asMain > div.as-Overlay.is-visible > div > div > div > div > div.yqXErLhpudpgwonrEvEXg > div > div > div > h1").text }
    @driver.find_element(:css, "a > div:nth-of-type(2) > div").click
    sleep 2
    verify { assert_equal "E-Mail", @driver.find_element(:css, "div.panel-body > div:first-child > div.flex-row > div.flex-cell.flex-spread.row-data > div > div > label.control-label > span:first-child").text }
    sleep 2
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Tiger"

    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "#asMain > div.as-Overlay.is-visible > div > div > div > div > div.yqXErLhpudpgwonrEvEXg > div > div > div > h1").text }
    @driver.find_element(:class, "_3STZvC8XeDxxzpb_UoVzM6").click
    sleep 2
    verify { assert_equal "E-Mail", @driver.find_element(:css, "div.panel-body > div:first-child > div.flex-row > div.flex-cell.flex-spread.row-data > div > div > label.control-label > span:first-child").text }
    sleep 2
#search with result and clicking on appointment icon
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Tiger"

    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "div#asMain div._2T5rEwoADOfXBF7EfxFohN > a:nth-child(1) > i").click
    sleep 4
    @driver.find_element(:css, "div#asMain div.as-Overlay.is-visible > div > button > i").click
    sleep 4
#search with result, clicking on chat icon and start chat
    @driver.get "https://app-shell-staging.shore.com/calendar/week"
    sleep 5
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Tiger"

    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "i.shore-icon-backend-new-message").click
    sleep 6
    @driver.find_element(:css, "input.form-control.mmw-text-input").send_keys "Was geht den hier ab?"
    sleep 2
    @driver.find_element(:css, "button.btn.btn-primary.mmw-submit-button").click
    sleep 2
    assert(@driver.find_element(:css => "div.mmw-fetched-messages-coontainer > div.panel-body.mmw-panel-body").text.include?("Was geht den hier ab?"),"Assertion Pass")

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
