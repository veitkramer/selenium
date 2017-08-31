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

          def test_booking_multi_payment_appshell

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
                   @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
                else checkbox.click
                end
                @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
                    sleep 1

        #book appointment
                @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
                @driver.find_element(:css, "div.items > div:nth-of-type(1) > div.item-group-title").click
                @driver.find_element(:css, "div.item-group.expanded > div:nth-of-type(2) > div.item-content > div.item-content-left").click
                sleep 1
                @driver.find_element(:css, "div.item-group.expanded > div:nth-of-type(3) > div.item-content > div.item-content-left").click
                sleep 1
                @driver.find_element(:css, "button.widget-button.services-submit-button").click
                sleep 1
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
                @driver.find_element(:css, "input#first-name.ember-view.ember-text-field.form-control").send_keys "Bobby"
                @driver.find_element(:css, "input#last-name.ember-view.ember-text-field.form-control").send_keys "Bonds"
                @driver.find_element(:css, "input#email.ember-view.ember-text-field.form-control").send_keys "js+bb@shore.com"
                @driver.find_element(:css, "input#mobile.ember-view.ember-text-field.phonable.form-control").send_keys "88888888888888"
                @driver.find_element(:css, "input#addressStreet.ember-view.ember-text-field.form-control").send_keys "Masterroad"
                @driver.find_element(:css, "input#addressPostalCode.ember-view.ember-text-field.form-control").send_keys "8000"
                @driver.find_element(:css, "input#addressCity.ember-view.ember-text-field.form-control").send_keys "Minga"
                @driver.find_element(:css, "input#customer-custom_attribute-89.ember-view.ember-text-field.form-control").send_keys "At home"
                @driver.find_element(:css, "div.form-container.data > div.action-row.step-footer > button.widget-button.widget-button-submit").click
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
