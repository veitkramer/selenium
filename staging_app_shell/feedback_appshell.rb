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

  def test_feedback

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

    @driver.get "https://staging.shore.com/merchant/widget?appshell=true"

    checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_display_feedback_in_booking");
        if checkbox.selected?
          @driver.find_element(:name, "commit").click
          else
            checkbox.click

            end
            @driver.find_element(:name, "commit").click

    @driver.get "https://app-shell-staging.shore.com/feedback"

    sleep 3

    verify { assert_include @driver.find_element(:css, "th.mtw-header-column.mtw-header-customer").text, "KUNDE" }

    verify { assert_include @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td.mtw-customer").text, "Woods" }

    checkbox = @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td.mtw-public > div.checkbox.checkbox-slider.checkbox-slider--b-flat > label > span");
        if checkbox.selected?
          @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
          else
            checkbox.click
            @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
            end

      verify { assert_include @driver.find_element(:css, "#feedback > li:nth-of-type(1) > div > div.comment").text, "Best service ever"}


  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
