require "json"
require "selenium-webdriver"
require "test/unit"

class LogIn < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
  @driver.quit()
    assert_equal [], @verification_errors
  end

  def test_booking_payment

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#check bookingrules if request is enable or not
        @driver.get "https://staging.shore.com/merchant/sign_in"
        @driver.find_element(:id, "merchant_account_email").clear
        @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
        @driver.find_element(:id, "merchant_account_password").clear
        @driver.find_element(:id, "merchant_account_password").send_keys "secret"
        @driver.find_element(:name, "button").click

        @driver.get "https://staging.shore.com/merchant/bookings"
        checkbox = @driver.find_element(:css, "input#merchant_profile_direct_bookable.boolean.optional");
        if checkbox.selected?
           @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        else checkbox.click
        end
        @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            sleep 1
            # set payment optional
            @driver.get "https://staging.shore.com/merchant/bookings"
            @driver.find_element(:css, "#merchant_profile_config_attributes_customer_payment_chosen > a").click
            @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(2)").click
            @driver.find_element(:css, "#edit_merchant_profile_3 > div.tile-footer > input").click
#book appointment with payment
        @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
        @driver.find_element(:css, "div.item-group-title").click
        sleep 1
        @driver.find_element(:css, "div.item-content").click
        sleep 1
        @driver.find_element(:css, "button.widget-button.services-submit-button").click
        sleep 1
        @driver.find_element(:css, "div.item-content.with-icons").click
        sleep 1
        @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
        sleep 5
        @driver.find_element(:css, "div.jspPane > div:nth-of-type(4) > div:nth-of-type(1)").click
        sleep 1
        @driver.find_element(:css, "#timeslotStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
        sleep 1
        @driver.find_element(:css, "select#gender.ember-view.ember-select.form-control").click
        sleep 1
        @driver.find_element(:css, "input#first-name.ember-view.ember-text-field.form-control").send_keys "Andrew"
        @driver.find_element(:css, "input#last-name.ember-view.ember-text-field.form-control").send_keys "Cannon"
        @driver.find_element(:css, "input#email.ember-view.ember-text-field.form-control").send_keys "js+andrew@shore.com"
        @driver.find_element(:css, "input#mobile.ember-view.ember-text-field.phonable.form-control").send_keys "33333333333333"
        @driver.find_element(:css, "input#addressStreet.ember-view.ember-text-field.form-control").send_keys "Masterroad"
        @driver.find_element(:css, "input#addressPostalCode.ember-view.ember-text-field.form-control").send_keys "8000"
        @driver.find_element(:css, "input#addressCity.ember-view.ember-text-field.form-control").send_keys "Minga"
        @driver.find_element(:css, "input#customer-custom_attribute-89.ember-view.ember-text-field.form-control").send_keys "At home"
        @driver.find_element(:css, "input#special-wishes.ember-view.ember-text-field.form-control").send_keys "keine"
        @driver.find_element(:id, "pmcc").click
        @driver.find_element(:css, "input#ccnum.ember-view.ember-text-field.form-control").send_keys "4242 4242 4242 4242"
        @driver.find_element(:css, "input#cc_holder.ember-view.ember-text-field.form-control").send_keys "The Dude"
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "exp-month")).select_by(:text, "12")
        Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "exp-year")).select_by(:text, "2026")
        @driver.find_element(:id, "cc-cvc").send_keys "121"
        @driver.find_element(:css, "div.form-container.data > div.action-row.step-footer > button.widget-button.widget-button-submit").click
        sleep 3
        verify { assert_equal "Ihr Termin ist gebucht.", @driver.find_element(:css, "h5.status-headline").text }
#check status payment
        @driver.get "https://staging.shore.com/merchant/app/payments"
        verify { assert_include @driver.find_element(:css, "tbody.mtw-rows > tr:nth-of-type(1) > td:nth-of-type(6) > div.mtw-column-charge-status > span").text, "Erfolgreich" }

  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @driver.quit()
    @verification_errors << ex
  end
end
