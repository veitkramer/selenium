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

  def test_bookingrules

    target_size = Selenium::WebDriver::Dimension.new(1420, 940)
    @driver.manage.window.size = target_size
    
#login
    @driver.get "https://staging.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click

#check person count
            @driver.get "https://staging.shore.com/merchant/bookings"
            @driver.find_element(:css, "#btnCloseMainNav").click
            sleep 2
            checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_required_capacity.boolean.optional");
                if checkbox.selected?
                  @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
                  else
                    checkbox.click
                    @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
                    end

            @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
            sleep 4

    assert(@driver.find_element(:css => "#requiredCapacityStep > div.step-content-wrapper").text.include?("Wählen Sie aus, für wie viele Personen der Termin gebucht werden soll."),"Assertion Pass")
            @driver.get "https://staging.shore.com/merchant/bookings"
            checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_required_capacity.boolean.optional");
                if checkbox.selected?
                  checkbox.click
                    @driver.find_element(:css, "#edit_merchant_profile_3 > div.tile-footer > input").click
                  end
                  @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
#check notice during booking process
                @driver.get "https://staging.shore.com/merchant/bookings"
                checkbox = @driver.find_element(:css, "input#show_widget_hint_field");
                if checkbox.selected?
                  @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
                  else
                    checkbox.click
                        end
                        @driver.find_element(:css, "#merchant_profile_widget_hint_text").clear
                        @driver.find_element(:css, "#merchant_profile_widget_hint_text").send_keys "Check you'r swing"

                        @driver.find_element(:css, "div.customer_notes > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click

                        @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
                    sleep 4
                    assert(@driver.find_element(:css => "header.merchant-hint-text.text-center").text.include?("Check you'r swing"),"Assertion Pass")

                    @driver.get "https://staging.shore.com/merchant/bookings"
                    @driver.find_element(:css, "input#show_widget_hint_field").click
#set with no preference
    @driver.get "https://staging.shore.com/merchant/bookings"
    checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_no_preference_in_booking.boolean.optional");
    if checkbox.selected?
      @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
      else
        checkbox.click
    end
    @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 4
    @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
    @driver.find_element(:css, "div.items > div:nth-of-type(1) > div.item-group-title").click
    sleep 4
    @driver.find_element(:css, "div.item-group.expanded > div:nth-of-type(2) > div.item-content > div.item-content-left").click
    sleep 4
    @driver.find_element(:css, "button.widget-button.services-submit-button").click
    sleep 4
    verify { assert_equal "Keine Präferenz", @driver.find_element(:css, "div.items > div:nth-of-type(1) > div.item-content.with-icons > div.item-content-left > div.item-name").text }
    @driver.get "https://staging.shore.com/merchant/bookings"
    @driver.find_element(:css, "input#merchant_profile_config_attributes_display_no_preference_in_booking.boolean.optional").click
    @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(1) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 4
#booking limits
    @driver.find_element(:css, "#merchant_profile_lead_time").clear
    @driver.find_element(:css, "#merchant_profile_lead_time").send_keys "2400"
    @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(2) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 4
    @driver.get "https://staging-connect.shore.com/widget/endeavourdude?locale=de&select_location=false"
    @driver.find_element(:css, "div.items > div:nth-of-type(1) > div.item-group-title").click
    sleep 4
    @driver.find_element(:css, "div.item-group.expanded > div:nth-of-type(2) > div.item-content > div.item-content-left").click
    sleep 4
    @driver.find_element(:css, "button.widget-button.services-submit-button").click
    sleep 4
    @driver.find_element(:css, "div.item-content.with-icons > div.item-content-left > div.item-name").click
    sleep 4
    @driver.find_element(:css, "#resourceStep > div.step-content-wrapper > div.step-footer > button.widget-button.services-submit-button").click
    sleep 4
    verify { assert_equal "Diese Woche stehen leider keine online buchbaren Termine mehr zur Verfügung.", @driver.find_element(:css, "div.text-muted > span").text }
    @driver.get "https://staging.shore.com/merchant/bookings"
    @driver.find_element(:css, "#merchant_profile_lead_time").clear
    @driver.find_element(:css, "#merchant_profile_lead_time").send_keys "0"
    @driver.find_element(:css, "div.row-fluid > div:nth-of-type(1) > div:nth-of-type(2) > div.tile-autoload > div > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
    sleep 4

#add and delete tax
        @driver.get "https://staging.shore.com/merchant/bookings"
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div:nth-of-type(1) > input.tax-category-name").clear
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div:nth-of-type(1) > input.tax-category-name").send_keys "TestTax"
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div:nth-of-type(2) > input").clear
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div:nth-of-type(2) > input").send_keys "VAT"
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div.with-unit > input").clear
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div.with-unit > input").send_keys "19"

        @driver.find_element(:css, "div.tax-categories-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 5
        @driver.find_element(:css, "div.auto-row-container.tax-categories > div:nth-of-type(5) > div.row-fluid > div.remove > a > i.icon-remove").click
        @driver.find_element(:css, "div.tax-categories-settings > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
#change sender id sms and email
        @driver.get "https://staging.shore.com/merchant/bookings"
        @driver.find_element(:css, "input#merchant_profile_config_attributes_custom_sender_id").clear
        @driver.find_element(:css, "input#merchant_profile_config_attributes_custom_sender_id").send_keys "Dude"
        @driver.find_element(:css, "div.custom_sender_id > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 3
        @driver.find_element(:css, "input#merchant_profile_config_attributes_shortened_name_for_sms.string.optional").clear
        @driver.find_element(:css, "input#merchant_profile_config_attributes_shortened_name_for_sms.string.optional").send_keys "Endeavourdude"
        @driver.find_element(:css, "div.row-fluid > div:nth-of-type(2) > div:nth-of-type(5) > div.tile-autoload > div.shortened_sms_name > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 3
        @driver.find_element(:css, "input#merchant_profile_config_attributes_individual_email_from_name.string.optional").clear
        @driver.find_element(:css, "input#merchant_profile_config_attributes_individual_email_from_name.string.optional").send_keys "StagingDude"
        @driver.find_element(:css, "div.individual_email_from_name > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 3
#enable working steps
        @driver.get "https://staging.shore.com/merchant/bookings"
        checkbox = @driver.find_element(:css, "input#serviceStepsCheckbox.boolean.optional");
        if checkbox.selected?
        @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          else
            checkbox.click
              end
        sleep 3
        @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 3
        @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click
        @driver.find_element(:css, "div.close-button > a > i.shore-icon-backend-nav-close").click
        sleep 3
        @driver.get "https://staging.shore.com/merchant/bookings"
        checkbox = @driver.find_element(:css, "input#serviceStepsCheckbox.boolean.optional");
        if checkbox.selected?
        checkbox.click
          else
            @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            end
        sleep 3
        @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
        sleep 3
        @driver.find_element(:css, "i.shore-icon-backend-new-appointment").click
        sleep 3
        @driver.find_element(:css, "div.close-button > a > span").click
        @driver.find_element(:css, "button.close > i.shore-icon-backend-delete").click
        @driver.get "https://staging.shore.com/merchant/bookings"
        @driver.find_element(:css, "input#serviceStepsCheckbox.boolean.optional").click
        @driver.find_element(:css, "div.service-steps-config > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
  end


  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
