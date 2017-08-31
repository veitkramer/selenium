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

  def test_searching

    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 2
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
#search with no result
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").send_keys "Scheissnewand"
    sleep 2
    verify { assert_equal "Es wurde bei dieser Suchanfrage leider nichts gefunden!\nVersuchen Sie es am Besten mit einem anderem Suchbegriff.", @driver.find_element(:css, "div#asMain div.as-Overlay.is-visible > div > div > div > div > div").text }
    sleep 2
#search with result and go to customer page
    @driver.find_element(:css, "#searchInput").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "a > div:nth-of-type(2) > div").click
    sleep 5
    verify { assert_equal "E-Mail", @driver.find_element(:css, "div.panel-body > div:first-child > div.flex-row > div.flex-cell.flex-spread.row-data > div > div > label.control-label > span:first-child").text }
    sleep 2
#search with result and clicking on appointment icon
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "div#asMain div._2T5rEwoADOfXBF7EfxFohN > a:nth-child(1) > i").click
    sleep 5
    @driver.find_element(:css, "div#asMain div.as-Overlay.is-visible > div > button > i").click
    sleep 5
#search with result, clicking on chat icon and start chat
    @driver.find_element(:class, "as-SearchWrapper-trigger").click
    @driver.find_element(:class, "_24k3MNSCOcuLswVqRr005e").clear
    @driver.find_element(:css, "#searchInput").send_keys "Tiger"
    sleep 2
    verify { assert_equal "Tiger Woods", @driver.find_element(:css, "h1._5DvwLS3Ik70JNJVC7_lV1").text }
    @driver.find_element(:css, "div#asMain a:nth-child(2) > i").click
    sleep 6
    @driver.find_element(:css, "#asMain div.mmw-cell.mmw-text-input-cell > input").click
    sleep 2
    @driver.find_element(:css, "#asMain div.mmw-cell.mmw-text-input-cell > input").send_keys "Was geht ab?"
    sleep 2
    @driver.find_element(:css, "#asMain div.mmw-cell.mmw-text-input-button > button").click
    sleep 2

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
