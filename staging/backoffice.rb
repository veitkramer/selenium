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
# edit existing key account
    @driver.get "https://staging.shore.com/admin/merchant_key_accounts"
    sleep 3
    @driver.navigate().refresh()
    @driver.find_element(:id, "q_name").send_keys "#99"
    sleep 3
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.get "https://staging.shore.com/admin/merchant_key_accounts/jorg-99"
    verify { assert_include @driver.find_element(:css, "#main_content > div:nth-child(1) > h3").text, "Key account Details" }
    @driver.get"https://staging.shore.com/admin/merchant_key_accounts/jorg-99/edit"
    verify { assert_include @driver.find_element(:css, "#edit_merchant_key_account_2 > fieldset:nth-child(4) > legend > span").text, "Key Account"}
    @driver.find_element(:id, "merchant_key_account_name").clear
    @driver.find_element(:id, "merchant_key_account_name").send_keys "Hackfresse"
    sleep 2
    @driver.find_element(:id, "merchant_key_account_name").clear
    @driver.find_element(:id, "merchant_key_account_name").send_keys "Jörg #99"
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").clear
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").send_keys "25"
    sleep 2
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").clear
    @driver.find_element(:id, "merchant_key_account_max_number_of_profiles").send_keys "20"
    sleep 2
    @driver.find_element(:css, "#merchant_key_account_locale_chosen").click
    @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(3)").click
    sleep 2
    @driver.find_element(:css, "#merchant_key_account_locale_chosen").click
    @driver.find_element(:css, "ul.chosen-results > li:first-child").click
    sleep 2
# edit existing merchant
    @driver.get "https://staging.shore.com/admin/merchant_profiles/endeavourdude-12"
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click

    @driver.find_element(:id, "merchant_profile_name").clear
    @driver.find_element(:id, "merchant_profile_name").send_keys "Chromedriver"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_name").clear
    @driver.find_element(:id, "merchant_profile_name").send_keys "Endeavourdude #12"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_street").clear
    @driver.find_element(:id, "merchant_profile_street").send_keys "Chromeroad"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_street").clear
    @driver.find_element(:id, "merchant_profile_street").send_keys "Seidlstraße 23"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_postal_code").clear
    @driver.find_element(:id, "merchant_profile_postal_code").send_keys "99999"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_postal_code").clear
    @driver.find_element(:id, "merchant_profile_postal_code").send_keys "80335"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_city_name").clear
    @driver.find_element(:id, "merchant_profile_city_name").send_keys "Stinga"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_city_name").clear
    @driver.find_element(:id, "merchant_profile_city_name").send_keys "München"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div.chosen-drop > div.chosen-search > input").send_keys "United S"
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div > ul > li > em").click
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div.chosen-drop > div.chosen-search > input").send_keys "Germ"
    @driver.find_element(:css, "#merchant_profile_address_country_chosen > div > ul > li > em").click
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div.chosen-drop > div.chosen-search > input").send_keys "Beau"
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div > ul > li > em").click
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div.chosen-drop > div.chosen-search > input").send_keys "Other"
    @driver.find_element(:css, "#merchant_profile_main_category_slug_chosen > div > ul > li > em").click
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div.chosen-drop > div.chosen-search > input").send_keys "etc"
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div > ul > li > em").click
    @driver.find_element(:css, "div.ui-dialog-buttonset > button:first-child > span.ui-button-text").click
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > a.chosen-single > span").click
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div.chosen-drop > div.chosen-search > input").send_keys "europe/ber"
    @driver.find_element(:css, "#merchant_profile_time_zone_chosen > div > ul > li > em").click
    @driver.find_element(:css, "div.ui-dialog-buttonset > button:first-child > span.ui-button-text").click
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_phone_number").clear
    @driver.find_element(:id, "merchant_profile_phone_number").send_keys "099990909909"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_phone_number").clear
    @driver.find_element(:id, "merchant_profile_phone_number").send_keys "01748989898989"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_website").clear
    @driver.find_element(:id, "merchant_profile_website").send_keys "www.hackfresse.de"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_website").clear
    @driver.find_element(:id, "merchant_profile_website").send_keys "www.shore.com"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_description").clear
    @driver.find_element(:id, "merchant_profile_description").send_keys "Chill dich mal"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_description").clear
    @driver.find_element(:id, "merchant_profile_description").send_keys "The best swing ever"
    @driver.find_element(:id, "merchant_profile_submit_action").click

    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_opening_hours").clear
    @driver.find_element(:id, "merchant_profile_opening_hours").send_keys "So:
    Mo: 08:00-10:00
    Di: 08:00-10:00
    Mi: 08:00-10:00
    Do: 08:00-10:00
    Fr: 08:00-10:00
    Sa:"
    @driver.find_element(:id, "merchant_profile_submit_action").click
    @driver.find_element(:css, "div.action_items > span:nth-of-type(1) > a").click
    @driver.find_element(:id, "merchant_profile_opening_hours").clear
    @driver.find_element(:id, "merchant_profile_opening_hours").send_keys "
    So:
    Mo: 08:00-19:00
    Di: 08:00-19:00
    Mi: 08:00-19:00
    Do: 08:00-19:00
    Fr: 08:00-19:00
    Sa:"
    @driver.find_element(:id, "merchant_profile_submit_action").click

# edit service

    @driver.get "https://staging.shore.com/admin/merchant_profiles/endeavourdude-12/edit_services"
    @driver.find_element(:css, "a.button.has_many_add").click
    @driver.find_element(:css, "li.has_many_container.services > fieldset:nth-of-type(15) > ol > li.string.input.required.stringish > input").send_keys "Driver Service"
    @driver.find_element(:css, "li.has_many_container.services > fieldset:nth-of-type(15) > ol > li.string.input.optional.stringish > input").send_keys "99"
    @driver.find_element(:css, "li.has_many_container.services > fieldset:nth-of-type(15) > ol > li.text.input.optional > textarea").send_keys "Hallo Hallo"
    @driver.find_element(:id, "merchant_profile_submit_action").click

#remove service

    @driver.get "https://staging.shore.com/admin/merchant_profiles/endeavourdude-12/edit_services"
    @driver.find_element(:css, "li.has_many_container.services > fieldset:nth-of-type(1) > ol > li.boolean.input.optional > label > input").click
    @driver.find_element(:id, "merchant_profile_submit_action").click


















  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
