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

  def test_newsletter_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 2
#create newsletter and send
    @driver.get "https://app-shell-staging.shore.com/newsletter"
    @driver.find_element(:css, "div#asMain span:nth-child(3)").click
#go back
    @driver.find_element(:css, "i.shore-icon-backend-previous.icon.pull-left").click
    @driver.find_element(:css, "div#asMain span:nth-child(3)").click
    @driver.find_element(:name, "variables.subject").clear
    @driver.find_element(:name, "variables.subject").send_keys "Automatic generated send"
    @driver.find_element(:name, "variables.title").clear
    @driver.find_element(:name, "variables.title").send_keys "Automatic generated send"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "variables.salutation")).select_by(:text, "Lieber Kunde,")
    @driver.find_element(:name, "variables.content").clear
    @driver.find_element(:name, "variables.content").send_keys "Automatic generated"
    sleep 5
    @driver.find_element(:css, "i.shore-icon-backend-next.icon.pull-right").click
    @driver.find_element(:css, "span[title=\"Abel Joyce\"]").click
    @driver.find_element(:css, "i.shore-icon-backend-next.icon.pull-right").click
    sleep 3
    @driver.find_element(:css, "button.btn.btn-primary.btn-primary-mod").click
    sleep 2
    verify { assert_equal "Erfolgreich zugestellt", @driver.find_element(:css, "div#asMain tr:nth-child(1) > td:nth-child(2) > div > span").text }
#create draft
    @driver.find_element(:css, "div#asMain span:nth-child(3)").click
    @driver.find_element(:name, "variables.subject").clear
    @driver.find_element(:name, "variables.subject").send_keys "Automatic generated send"
    @driver.find_element(:name, "variables.title").clear
    @driver.find_element(:name, "variables.title").send_keys "Automatic generated send"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "variables.salutation")).select_by(:text, "Lieber Kunde,")
    @driver.find_element(:name, "variables.content").clear
    @driver.find_element(:name, "variables.content").send_keys "Automatic generated"
    sleep 3
    @driver.find_element(:css, "i.shore-icon-backend-safe.icon").click
    sleep 2
    @driver.find_element(:css, "i.shore-icon-backend-previous.icon.pull-left").click
    sleep 2
    verify { assert_equal "Entwurf", @driver.find_element(:css, "div#asMain tr:nth-child(1) > td:nth-child(2) > div > span").text }
#create newsletter and schedule
@driver.find_element(:css, "div#asMain span:nth-child(3)").click
    @driver.find_element(:name, "variables.subject").clear
    @driver.find_element(:name, "variables.subject").send_keys "Automatic generated send"
    @driver.find_element(:name, "variables.title").clear
    @driver.find_element(:name, "variables.title").send_keys "Automatic generated send"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "variables.salutation")).select_by(:text, "Lieber Kunde,")
    @driver.find_element(:name, "variables.content").clear
    @driver.find_element(:name, "variables.content").send_keys "Automatic generated"
    sleep 5
    @driver.find_element(:css, "i.shore-icon-backend-next.icon.pull-right").click
    sleep 1
    @driver.find_element(:css, "span[title=\"Abel Joyce\"]").click
    sleep 1
    @driver.find_element(:css, "i.shore-icon-backend-next.icon.pull-right").click
    sleep 1
    @driver.find_element(:css,"button.btn.btn-default.btn-primary-mod.crud").click
    sleep 1
    @driver.find_element(:css, "span.DayPicker-NavButton.DayPicker-NavButton--next").click
    sleep 1
    @driver.find_element(:css, "div.DayPicker-Body > div:nth-of-type(2) > div:first-child").click
    sleep 1
    @driver.find_element(:css, "select#timePicker.form-control").click
    sleep 1
    @driver.find_element(:css, "#timePicker > option:nth-child(121)").click
    sleep 1
    @driver.find_element(:css, "button.btn.btn-primary.btn-primary-mod.btn-block.btn-send-later").click
    sleep 3
    verify { assert_equal "Festgelegt", @driver.find_element(:css, "div#asMain tr:nth-child(1) > td:nth-child(2) > div > span").text }

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
