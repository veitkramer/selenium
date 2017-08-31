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

  def test_widget

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size

    
#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#personcount
@driver.get "https://staging.shore.com/merchant/bookings"

checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_required_capacity");
    if checkbox.selected?
      @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
      else
        checkbox.click
        @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click

        end

  @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
  sleep 1
  verify { assert_include @driver.find_element(:css, "#requiredCapacityStep > div.step-content-wrapper > div.description").text, "Wählen Sie aus, für wie viele Personen der Termin gebucht werden soll." }

  @driver.get "https://staging.shore.com/merchant/bookings"

  checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_required_capacity");
      if checkbox.selected?
        checkbox.click
        @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        else
          @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          end

#Customers have to select the branch first
@driver.get "https://staging.shore.com/merchant/widget"
checkbox = @driver.find_element(:css, "input#merchant_profile_key_account_attributes_merchant_picker_in_booking_service.boolean.optional");
    if checkbox.selected?
      @driver.find_element(:css, "input.btn-blue").click
      else
        checkbox.click
        @driver.find_element(:css, "input.btn-blue").click
      end
sleep 3
verify { assert_include @driver.find_element(:css, "div.code-snippet-preview").text, "true" }
sleep 3
@driver.find_element(:css, "input#merchant_profile_key_account_attributes_merchant_picker_in_booking_service.boolean.optional").click
@driver.find_element(:css, "input.btn-blue").click
verify { assert_include @driver.find_element(:css, "div.code-snippet-preview").text, "true" }
#Inform customers about newsletter subscription on
@driver.get "https://staging.shore.com/merchant/widget"
checkbox = @driver.find_element(:css, "#merchant_profile_key_account_attributes_newsletter_terms");
    if checkbox.selected?
      @driver.find_element(:css, "input.btn-blue").click
      else
        checkbox.click
      end
      @driver.find_element(:css, "input.btn-blue").click
      @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
      @driver.find_element(:css, "div.item-group-title").click
      sleep 2
      @driver.find_element(:css, "div.item-content").click
      sleep 2
      @driver.find_element(:css, "button.widget-button.services-submit-button").click
      sleep 2
      @driver.find_element(:css, "div.item-content.with-icons").click
      sleep 2
      @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
      sleep 5
      @driver.find_element(:css, "div.jspPane > div:nth-of-type(5) > div:nth-of-type(1)").click
      sleep 1
      @driver.find_element(:css, "#timeslotStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
      sleep 1
      verify { assert_include @driver.find_element(:css, "#userStep > div.step-content-wrapper > div > div > div.form-row.widget-terms").text, "Im Falle der Buchung Ihres Termins" }
#Inform customers about newsletter subscription off
      @driver.get "https://staging.shore.com/merchant/widget"
      checkbox = @driver.find_element(:css, "#merchant_profile_key_account_attributes_newsletter_terms");
          if checkbox.selected?
            checkbox.click
            else
              @driver.find_element(:css, "input.btn-blue").click
            end
            @driver.find_element(:css, "input.btn-blue").click
      @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
      @driver.find_element(:css, "div.item-group-title").click
      sleep 2
      @driver.find_element(:css, "div.item-content").click
      sleep 2
      @driver.find_element(:css, "button.widget-button.services-submit-button").click
      sleep 2
      @driver.find_element(:css, "div.item-content.with-icons").click
      sleep 2
      @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
      sleep 5
      @driver.find_element(:css, "div.jspPane > div:nth-of-type(5) > div:nth-of-type(1)").click
      sleep 1
      @driver.find_element(:css, "#timeslotStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
      sleep 1
      verify { assert_include @driver.find_element(:css, "#userStep > div.step-content-wrapper > div > div > div.form-row.widget-terms").text, "dem Absenden des Formulars bestätige ich" }
#feeback shown
          @driver.get "https://staging.shore.com/merchant/widget"
          checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_display_feedback_in_booking");
            if checkbox.selected?
              @driver.find_element(:css, "input.btn-blue").click
              else
                checkbox.click
            end
            @driver.find_element(:css, "input.btn-blue").click
          @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
          sleep 2
          verify { assert_include @driver.find_element(:css, "body > div > div.secondary.light-shadow > div.widget-feedback").text, "Kundenbewertungen" }
#feeback not shown
    @driver.get "https://staging.shore.com/merchant/widget"
    checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_feedback_in_booking");
      if checkbox.selected?
          checkbox.click
        else
            @driver.find_element(:css, "input.btn-blue").click
            end
              @driver.find_element(:css, "input.btn-blue").click
                @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
                sleep 2
                @driver.get "https://staging.shore.com/merchant/widget"
                checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_feedback_in_booking");
                  if checkbox.selected?
                    @driver.find_element(:css, "input.btn-blue").click
                    else
                      checkbox.click
                      @driver.find_element(:css, "input.btn-blue").click
                  end
#gallery shown
        @driver.get "https://staging.shore.com/merchant/widget"
        checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_gallery_in_booking");
            if checkbox.selected?
            @driver.find_element(:css, "input.btn-blue").click
                                else
                                  checkbox.click
                              end
                              @driver.find_element(:css, "input.btn-blue").click
                            @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
                            sleep 2
                            verify { assert_include @driver.find_element(:css, "body > div > div.secondary.light-shadow > div.has-social-icons.widget-gallery > div.widget-social-links").text, "Folgen Sie uns" }
#gallery not shown
                      @driver.get "https://staging.shore.com/merchant/widget"
                      checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_gallery_in_booking");
                        if checkbox.selected?
                            checkbox.click
                          else
                              @driver.find_element(:css, "input.btn-blue").click
                              end
                                @driver.find_element(:css, "input.btn-blue").click
                                  @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de"
                                  sleep 2
                                  @driver.get "https://staging.shore.com/merchant/widget"
                                  checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_gallery_in_booking");
                                    if checkbox.selected?
                                      @driver.find_element(:css, "input.btn-blue").click
                                      else
                                        checkbox.click
                                        @driver.find_element(:css, "input.btn-blue").click
                                    end
#check if payment is shown in the widget if payment is off/on
      @driver.get "https://staging.shore.com/merchant/bookings"
      @driver.find_element(:css, "#merchant_profile_config_attributes_customer_payment_chosen > a").click
      sleep 1
      @driver.find_element(:css, "ul.chosen-results > li:first-child").click
      sleep 1
      @driver.find_element(:css, "#edit_merchant_profile_3 > div.tile-footer > input").click

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
      @driver.find_element(:css, "div.jspPane > div:nth-of-type(5) > div:nth-of-type(1)").click
      sleep 1
      @driver.find_element(:css, "#timeslotStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
      sleep 1
      @driver.find_element(:css, "select#gender.ember-view.ember-select.form-control").click
      sleep 1
      verify { assert_not_include @driver.find_element(:css, "#userStep > div.step-content-wrapper").text, "BEZAHLUNG" }
      sleep 2
      @driver.get "https://staging.shore.com/merchant/bookings"
      @driver.find_element(:css, "#merchant_profile_config_attributes_customer_payment_chosen > a").click
      @driver.find_element(:css, "ul.chosen-results > li:nth-of-type(2)").click
      @driver.find_element(:css, "#edit_merchant_profile_3 > div.tile-footer > input").click




  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
