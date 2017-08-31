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

  def test_permission_member_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js+ted@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    verify { assert_equal "[STAGING] Shore - Manage your customers", @driver.title }
    sleep 5
    @driver.get "https://app-shell-staging.shore.com/calendar/week#/launchpad"
    sleep 5
#checking if all apps are present

  #Kalender
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(1) > div.launchpadCategoryBody > a:first-child").text, "Kalender" }
    sleep 1
  #Kunden
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(1) > div.launchpadCategoryBody > a:nth-of-type(2)").text, "Kunden" }
    sleep 1
  #Web Widgets
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(2) > div.launchpadCategoryBody > a:first-child").text, "Web Widgets" }
    sleep 1
  #Errinerungen
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(2) > div.launchpadCategoryBody > a:nth-of-type(2)").text, "Erinnerungen" }
    sleep 1
  #Reserve with Google
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(2) > div.launchpadCategoryBody > a:nth-of-type(3)").text, "Reserve with Google" }
    sleep 1
  #Feedback
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(3) > div.launchpadCategoryBody > a:first-child").text, "Feedback" }
    sleep 1
  #Leistungen
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(4) > div.launchpadCategoryBody > a:first-child").text, "Leistungen" }
    sleep 1
  #Ressourcen
    verify { assert_include @driver.find_element(:css, "div.launchpadMain > section:nth-of-type(4) > div.launchpadCategoryBody > a:nth-of-type(2)").text, "Ressourcen" }
    sleep 1
  #Messenger
    verify { assert_include @driver.find_element(:css, "[href=\"#/messenger\"]").text, "Messenger" }
    sleep 1

  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
