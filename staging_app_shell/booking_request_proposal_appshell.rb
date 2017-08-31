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

  def test_booking_request_accept_appshell

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

#check bookingrules if request is enable or not
        @driver.get "https://staging.shore.com/merchant/sign_in"
        @driver.find_element(:id, "merchant_account_email").clear
        @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
        @driver.find_element(:id, "merchant_account_password").clear
        @driver.find_element(:id, "merchant_account_password").send_keys "secret"
        @driver.find_element(:name, "button").click

        @driver.get "https://staging.shore.com/merchant/bookings?appshell=true&merchant_profile_id=98a23f30-7a65-4605-aea7-b81c56f8e027"

        checkbox = @driver.find_element(:css, "input#merchant_profile_direct_bookable.boolean.optional");
        if checkbox.selected?
          checkbox.click
        end

        @driver.find_element(:css, "input.btn-blue").click
        sleep 1
#book appointment
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
        @driver.find_element(:css, "input#first-name.ember-view.ember-text-field.form-control").send_keys "Ernie"
        @driver.find_element(:css, "input#last-name.ember-view.ember-text-field.form-control").send_keys "Else"
        @driver.find_element(:css, "input#email.ember-view.ember-text-field.form-control").send_keys "js+ee@shore.com"
        @driver.find_element(:css, "input#mobile.ember-view.ember-text-field.phonable.form-control").send_keys "444444444444444"
        @driver.find_element(:css, "input#addressStreet.ember-view.ember-text-field.form-control").send_keys "Masterroad"
        @driver.find_element(:css, "input#addressPostalCode.ember-view.ember-text-field.form-control").send_keys "8000"
        @driver.find_element(:css, "input#addressCity.ember-view.ember-text-field.form-control").send_keys "Minga"
        @driver.find_element(:css, "input#customer-custom_attribute-89.ember-view.ember-text-field.form-control").send_keys "At home"
        @driver.find_element(:css, "input#special-wishes.ember-view.ember-text-field.form-control").send_keys "keine"
        @driver.find_element(:css, "div.form-container.data > div.action-row.step-footer > button.widget-button.widget-button-submit").click
        sleep 3

        verify { assert_equal "Ihre Terminanfrage wurde übermittelt.", @driver.find_element(:css, "h5.status-headline").text }
#proposal alternative
        @driver.get "https://app-shell-staging.shore.com/calendar"
        sleep 5
        @driver.find_element(:css, "div.merchant-notification-widget-container > div:nth-of-type(1) > span.badge.mnw-badge").click
        @driver.find_element(:css, "ul.mnw-list > li:first-child > div.mnw-content > div.mnw-requested-date").click
        @driver.find_element(:css, "div.actions-template > button.btn.btn-mute").click #alternative
        sleep 5
        @driver.find_element(:css, "td.is-inside-period > button.pika-button.pika-day").click #day
        sleep 5
        @driver.find_element(:css, "div.panel-footer > button.btn.btn-primary.pull-right").click #vorschlagen
        sleep 5
        @driver.find_element(:css, "div.modal-footer > button.btn.btn-primary").click #confirm
        sleep 5
        @driver.navigate().back()
        @driver.navigate().back()
        @driver.navigate().back()

        @driver.navigate().refresh()
        sleep 3
        @driver.find_element(:css, "body > div > div > div.container > div.panel.panel-default.appointment-details-panel > div > div > div.col-xs-12.col-sm-4.actions-container > div > button.btn.btn-block.btn-primary").click
        sleep 10




  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @driver.quit()
    @verification_errors << ex
  end
end
