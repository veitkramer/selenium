require "json"
require "selenium-webdriver"
require "test/unit"

class LogIn < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://staging.shore.com/admin/login"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_backoffice
    
    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    @driver.get "https://staging.shore.com/admin/login"
    @driver.find_element(:id, "admin_user_email").clear
    @driver.find_element(:id, "admin_user_email").send_keys "js@shore.com"
    @driver.find_element(:id, "admin_user_password").clear
    @driver.find_element(:id, "admin_user_password").send_keys "secret2014_1A!_24"
    @driver.find_element(:id, "admin_user_submit_action").click
    sleep 3
    verify { assert_equal "Dashboard | Backoffice", @driver.title }

#create key account

    @driver.get "https://staging.shore.com/admin/merchant_key_accounts"
    @driver.find_element(:css, "span.action_item > a").click

    @driver.find_element(:id, "merchant_key_account_name").send_keys "Created by selenium-webdriver"
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").clear
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").send_keys "20"
    @driver.find_element(:id, "merchant_key_account_max_number_of_employees").clear
    @driver.find_element(:id, "merchant_key_account_max_number_of_employees").send_keys "20"

    @driver.find_element(:id, "merchant_key_account_test_true").click
    @driver.find_element(:id, "merchant_key_account_key_account_contract_true").click

    @driver.find_element(:id, "merchant_key_account_locale_chosen").click
    @driver.find_element(:css, "div.chosen-search > input").send_keys "span"
    @driver.find_element(:css, "#merchant_key_account_locale_chosen > div > ul > li > em").click

    @driver.find_element(:id, "merchant_key_account_feature_toggles_api_token_1").click
    @driver.find_element(:id, "merchant_key_account_feature_toggles_appointment_location_customer_1").click
    @driver.find_element(:id, "merchant_key_account_feature_toggles_booking_with_availability_2016_1").click
    @driver.find_element(:id, "merchant_key_account_feature_toggles_calendar2_resource_view_1").click
    @driver.find_element(:id, "merchant_key_account_submit_action").click

#create merchant

    @driver.get "https://staging.shore.com/admin/merchant_key_accounts"
    @driver.find_element(:id, "q_name").send_keys "Created by selenium-webdriver"
    @driver.find_element(:css, "td.col.col-name > a").click
    @driver.find_element(:css, "#main_content > div:nth-of-type(2) > div.panel_contents > p > a").click

    @driver.find_element(:id, "merchant_profile_name").clear
    @driver.find_element(:id, "merchant_profile_name").send_keys "Chromedriver"

    @driver.find_element(:id, "merchant_profile_street").clear
    @driver.find_element(:id, "merchant_profile_street").send_keys "Chromeroad"


    @driver.find_element(:id, "merchant_profile_postal_code").clear
    @driver.find_element(:id, "merchant_profile_postal_code").send_keys "99999"

    @driver.find_element(:id, "merchant_profile_city_name").clear
    @driver.find_element(:id, "merchant_profile_city_name").send_keys "Stinga"

    @driver.find_element(:css, "#merchant_profile_address_country_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div.chosen-drop > div.chosen-search > input").send_keys "United S"
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div > ul > li > em").click

    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div.chosen-drop > div.chosen-search > input").send_keys "Beau"
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div > ul > li > em").click

    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div.chosen-drop > div.chosen-search > input").send_keys "etc"
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div > ul > li > em").click

    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div.chosen-drop > div.chosen-search > input").send_keys "europe/ber"
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div > ul > li > em").click
    @driver.find_element(:css, "div.ui-dialog-buttonset > button:first-child > span.ui-button-text").click

    @driver.find_element(:id, "merchant_profile_phone_number").clear
    @driver.find_element(:id, "merchant_profile_phone_number").send_keys "01748989898989"

    @driver.find_element(:id, "merchant_profile_website").clear
    @driver.find_element(:id, "merchant_profile_website").send_keys "www.hackfresse.de"

    @driver.find_element(:id, "merchant_profile_description").clear
    @driver.find_element(:id, "merchant_profile_description").send_keys "Chill dich mal"

    @driver.find_element(:id, "merchant_profile_opening_hours").clear
    @driver.find_element(:id, "merchant_profile_opening_hours").send_keys "So:
    Mo: 08:00-10:00
    Di: 08:00-10:00
    Mi: 08:00-10:00
    Do: 08:00-10:00
    Fr: 08:00-10:00
    Sa:"
    @driver.find_element(:id, "merchant_profile_submit_action").click

#create admin

    @driver.get "https://staging.shore.com/admin/merchant_key_accounts"
    @driver.find_element(:id, "q_name").send_keys "Created by selenium-webdriver"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:css, "tbody > tr:nth-of-type(1) > td.col.col-name > a").click
    @driver.find_element(:css, "#main_content > div:nth-of-type(3) > div.panel_contents > p > a").click
    sleep 4
    @driver.find_element(:id, "employee_email").send_keys "#{rand(36**10).to_s(36)}+webdriver@shore.com"
    sleep 4
    @driver.find_element(:id, "employee_surname").send_keys "Driver"
    sleep 4
    @driver.find_element(:id, "employee_submit_action").click

#rename key account

  @driver.get "https://staging.shore.com/admin/merchant_key_accounts"
  @driver.find_element(:id, "q_name").send_keys "Created by selenium-webdriver"
  @driver.find_element(:css, "td.col.col-name > a").click

  @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
  @driver.find_element(:id, "merchant_key_account_name").clear
  @driver.find_element(:id, "merchant_key_account_name").send_keys "Remove This One"

  @driver.find_element(:id, "merchant_key_account_submit_action").click

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
