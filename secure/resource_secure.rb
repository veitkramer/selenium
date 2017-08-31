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

  def test_resource
#login
    @driver.get "https://secure.shore.com/merchant/sign_in"
    sleep 1
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    @driver.get "https://secure.shore.com"
    verify { assert_equal "Shore - Manage your customers", @driver.title }
    sleep 5
#go to resources
    @driver.get "https://my.shore.com/calendar/week#/launchpad"
    sleep 5
#open wraper in inframe
    @driver.get "https://secure.shore.com/merchant/resources?appshell=true&merchant_profile_id=8112b82a-2f10-422b-9d38-6eda1ed23a63"
    sleep 5
#create resource table
    @driver.find_element(:css, "a.btn-orange.fancybox").click
    @driver.find_element(:id, "resource_name").clear
    @driver.find_element(:id, "resource_name").send_keys "Chromedriver"
    @driver.find_element(:id, "resource_table_attributes_max_capacity").clear
    @driver.find_element(:id, "resource_table_attributes_max_capacity").send_keys "10"
    @driver.find_element(:id, "resource_visible").click
    @driver.find_element(:id, "resource_all_services").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(1) > a").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(2) > a").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(3) > a").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(4) > a").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(5) > a").click
    @driver.find_element(:css, "div.tag-style > ul > li:nth-of-type(6) > a").click
    @driver.find_element(:id, "booking_hours_inherited").click
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(1) > label.checkbox > input").click
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(2) > label.checkbox > input").click
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(3) > label.checkbox > input").click
    @driver.find_element(:css, "div.auto-row-container > div:first-child > div.row-fluid > div:nth-of-type(4) > label.checkbox > input").click
    @driver.find_element(:id, "select2-chosen-6").click
    @driver.find_element(:id, "s2id_autogen6_search").send_keys "10:00"
    @driver.action.send_keys(:enter).perform
    @driver.find_element(:id, "select2-chosen-7").click
    @driver.find_element(:id, "s2id_autogen7_search").send_keys "18:00"
    @driver.action.send_keys(:enter).perform
    sleep 3
    @driver.find_element(:css, "#new_resource > div.tile-footer > button").click
#edit ressource
    sleep 3
    element = @driver.find_element(:css, "div#resources.sortable.ui-sortable")
    sleep 3
    @driver.action.move_to(element).perform
    sleep 3
    @driver.find_element(:link, "Bearbeiten").click
    @driver.find_element(:id, "resource_name").clear
    @driver.find_element(:id, "resource_name").send_keys "Delete me please"
    @driver.find_element(:id, "resource_visible").click
    @driver.find_element(:id, "booking_hours_inherited").click
    sleep 3
    @driver.find_element(:css, "button.btn-blue").click
#delete resource
    sleep 3
    element = @driver.find_element(:css, "div#resources.sortable.ui-sortable")
    sleep 3
    @driver.action.move_to(element).perform
    sleep 3
    @driver.find_element(:link, "Entfernen").click
    sleep 3
    @driver.switch_to.alert.accept
    sleep 3

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
