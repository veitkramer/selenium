require "json"
require "selenium-webdriver"
require "test/unit"


class LogIn < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://secure.shore.com/merchant/sign_in"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  endB

  def test_account

    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 3
    #change account language
    @driver.get "https://secure.shore.com/merchant/account?appshell=true&merchant_profile_id=2f475a27-162b-4994-857f-399d6acf25ea"
    sleep 2
    @driver.find_element(:id, "merchant_key_account_locale_chosen").click
    sleep 4
    @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(3)").click
    sleep 2
    @driver.find_element(:css, "div.account > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 3
    @driver.navigate().refresh()
    verify { assert_equal "Language", @driver.find_element(:css, "div.row-fluid > div:nth-of-type(2) > div:nth-of-type(1) > div.tile-header > h2").text }
    sleep 2
    @driver.find_element(:id, "merchant_key_account_locale_chosen").click
    sleep 2
    @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(1)").click
    sleep 2
    @driver.find_element(:css, "div.account > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 3
    @driver.navigate().refresh()
    verify { assert_equal "Sprache", @driver.find_element(:css, "div.row-fluid > div:nth-of-type(2) > div:nth-of-type(1) > div.tile-header > h2").text }




  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
end
