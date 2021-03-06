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

  def test_payment

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size
    
#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#ckeck page loading
  @driver.get "https://staging.shore.com/merchant/app/payments"
  assert_equal @driver.find_element(tag_name: 'body').text.include?("NAME"), false
#create merchant payments
  @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click
  sleep 5
  @driver.find_element(:css, "a.style__link___1NHuj > i.shore-icon-backend-payment-card").click
  sleep 1
  @driver.find_element(:id, "id-for-customer.name").clear
  @driver.find_element(:id, "id-for-customer.name").send_keys "Tiger Woods"
  @driver.find_element(:id, "id-for-customer.email").clear
  @driver.find_element(:id, "id-for-customer.email").send_keys "js+tw@shore.com"
  @driver.find_element(:xpath, "(//button[@type='submit'])[2]").click
  @driver.find_element(:css, "input#mpw-services-0._3dGNJ3fWydt45ACq2ZWT2y.form-control").send_keys "Afterburner"
  sleep 3
  @driver.find_element(:css, "input#mpw-prices-0.form-control.price-input").send_keys "100"
  sleep 3
  @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
  @driver.find_element(:id, "id-for-cc.number").clear
  @driver.find_element(:id, "id-for-cc.number").send_keys "4242 4242 4242 4242"
  @driver.find_element(:id, "id-for-cc.cardholder").clear
  @driver.find_element(:id, "id-for-cc.cardholder").send_keys "The Dude"
  @driver.find_element(:name, "cc.expiration.month").send_keys "12"
  @driver.find_element(:name, "cc.expiration.year").send_keys "2021"
  @driver.find_element(:id, "mpw-cc-cvc").clear
  @driver.find_element(:id, "mpw-cc-cvc").send_keys "121"
  @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
  @driver.find_element(:name, "description").send_keys "The Dude paid"
  sleep 3
  @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
  sleep 4
  @driver.get "https://staging.shore.com/merchant/app/payments"
  verify { assert_equal "Erfolgreich", @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div > div.mtw-grid-content > table > tbody > tr:nth-child(1) > td:nth-child(6) > div > span").text }
#refund
 @driver.get "https://staging.shore.com/merchant/app/payments"
 @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(2)").click
 @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
 @driver.find_element(:id, "id-for-amount").send_keys "1"
 @driver.find_element(:css, "button.btn.btn-primary.pull-right").click
 sleep 4
 @driver.get "https://staging.shore.com/merchant/app/payments"
 verify { assert_equal "Teilweise erstattet", @driver.find_element(:css, "#MerchantAppContainer > div > div.view-container.noHeader > div > div > shore-app-wrapper > div > div > div > div.mtw-grid-content > table > tbody > tr:nth-child(1) > td:nth-child(6) > div > span").text }
#check refunded value
  @driver.get "https://staging.shore.com/merchant/app/payments"
  @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(2)").click
  verify { assert_include "99,00 €", @driver.find_element(:css, "span.no-left-padding.floated-label > input.form-control").text }
  verify { assert_include "1,00 €", @driver.find_element(:css, "span.no-right-padding.floated-label > input.form-control").text }
  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
