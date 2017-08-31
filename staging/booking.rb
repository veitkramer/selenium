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

  def test_booking

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#check bookingrules if request is enable or not
        @driver.get "https://staging.shore.com/merchant/sign_in"
        @driver.find_element(:id, "merchant_account_email").clear
        @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
        @driver.find_element(:id, "merchant_account_password").clear
        @driver.find_element(:id, "merchant_account_password").send_keys "secret"
        sleep 3
        @driver.find_element(:name, "button").click
        @driver.get "https://staging.shore.com/merchant/bookings"
        sleep 4
        checkbox = @driver.find_element(:css, "input#merchant_profile_direct_bookable.boolean.optional");
        if checkbox.selected?
           @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        else checkbox.click
        end
        @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            sleep 1
#book appointment
        @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
        @driver.find_element(:css, "div.item-group-title").click
        sleep 1
        @driver.find_element(:css, "div.item-content").click
        sleep 1
        @driver.find_element(:css, "button.widget-button.services-submit-button").click
        sleep 1
        verify { assert_include @driver.find_element(:css, "div.services-row-price.flex-cell.text-right").text, "55,00" }
        verify { assert_include @driver.find_element(:css, "div.total-row.flex-row > div.total-row-price.flex-cell.text-right").text, "60,50" }
        @driver.find_element(:css, "div.item-content.with-icons").click
        sleep 1
        @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
        sleep 5
        @driver.find_element(:css, "div.jspPane > div:nth-of-type(5) > div:nth-of-type(1)").click
        sleep 1
        @driver.find_element(:css, "#timeslotStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
        sleep 1
        @driver.find_element(:css, "select#gender.ember-view.ember-select.form-control").click
        sleep 1
        @driver.find_element(:css, "input#first-name.ember-view.ember-text-field.form-control").send_keys "Tiger"
        @driver.find_element(:css, "input#last-name.ember-view.ember-text-field.form-control").send_keys "Woods"
        @driver.find_element(:css, "input#email.ember-view.ember-text-field.form-control").send_keys "js+tw@shore.com"
        @driver.find_element(:css, "input#mobile.ember-view.ember-text-field.phonable.form-control").send_keys "01742199385"
        @driver.find_element(:css, "input#addressStreet.ember-view.ember-text-field.form-control").send_keys "Masterroad"
        @driver.find_element(:css, "input#addressPostalCode.ember-view.ember-text-field.form-control").send_keys "8000"
        @driver.find_element(:css, "input#addressCity.ember-view.ember-text-field.form-control").send_keys "Minga"
        @driver.find_element(:css, "input#customer-custom_attribute-89.ember-view.ember-text-field.form-control").send_keys "At home"
        @driver.find_element(:css, "input#special-wishes.ember-view.ember-text-field.form-control").send_keys "keine"
        @driver.find_element(:css, "button.widget-button.widget-button-submit").click
        sleep 3
        verify { assert_equal "Ihr Termin ist gebucht.", @driver.find_element(:css, "h5.status-headline").text }




  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @driver.quit()
    @verification_errors << ex
  end
end
