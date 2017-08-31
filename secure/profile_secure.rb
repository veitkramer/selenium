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

  def test_profile
    #login
        @driver.get "https://secure.shore.com/merchant/sign_in"
        @driver.find_element(:id, "merchant_account_email").clear
        @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
        @driver.find_element(:id, "merchant_account_password").clear
        @driver.find_element(:id, "merchant_account_password").send_keys "secret"
        @driver.find_element(:name, "button").click
        @driver.get "https://secure.shore.com"
        verify { assert_equal "Shore - Manage your customers", @driver.title }
        sleep 5
        @driver.get "https://my.shore.com/calendar/week#/launchpad"
        sleep 5
        #change company informations
        @driver.get "https://secure.shore.com/merchant/profile?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
        @driver.find_element(:css, "input#merchant_profile_street.string.optional").clear
        @driver.find_element(:css, "input#merchant_profile_street.string.optional").send_keys "Seidlstraße 23"
        @driver.find_element(:css, "input#merchant_profile_postal_code.string.optional").clear
        @driver.find_element(:css, "input#merchant_profile_postal_code.string.optional").send_keys "80335"
        @driver.find_element(:css, "input#merchant_profile_city_name.string.optional").clear
        @driver.find_element(:css, "input#merchant_profile_city_name.string.optional").send_keys "München"
        @driver.find_element(:css, "input#merchant_profile_phone_number.string.tel.optional").clear
        @driver.find_element(:css, "input#merchant_profile_phone_number.string.tel.optional").send_keys "01742499385"
        @driver.find_element(:css, "div.companies > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        #change company discription
        @driver.get "https://secure.shore.com/merchant/profile?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
        @driver.find_element(:css, "textarea#merchant_profile_description.text.optional").clear
        @driver.find_element(:css, "textarea#merchant_profile_description.text.optional").send_keys "The Best Swing"
        @driver.find_element(:css, "div.descriptions > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        #change opening hours
        @driver.get "https://secure.shore.com/merchant/profile?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
        sleep 4
        #@driver.find_element(:css, "input#merchant_profile_opening_hours_attributes_e22868d3_weekdays_1").click
        #@driver.find_element(:css, "input#merchant_profile_opening_hours_attributes_e22868d3_weekdays_2").click
        @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(8) > div.row-fluid > div:nth-of-type(1) > div > a > span:nth-of-type(1)").click
        @driver.find_element(:css, "ul > li:nth-of-type(33) > div").click
        @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(8) > div.row-fluid > div:nth-of-type(3) > div > a > span:nth-of-type(1)").click
        @driver.find_element(:css, "ul > li:nth-of-type(76) > div").click
        sleep 3
        @driver.find_element(:css, "div.tile-autoload > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 4
        @driver.get "https://secure.shore.com/merchant/profile?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
        sleep 4
        #@driver.find_element(:css, "input#merchant_profile_opening_hours_attributes_e22868d3_weekdays_1").click
        #@driver.find_element(:css, "input#merchant_profile_opening_hours_attributes_e22868d3_weekdays_2").click
        @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(8) > div.row-fluid > div:nth-of-type(1) > div > a > span:nth-of-type(1)").click
        @driver.find_element(:css, "ul > li:nth-of-type(34) > div").click
        @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(8) > div.row-fluid > div:nth-of-type(3) > div > a > span:nth-of-type(1)").click
        @driver.find_element(:css, "ul > li:nth-of-type(77) > div").click
        sleep 3
        @driver.find_element(:css, "div.tile-autoload > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 4



  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
