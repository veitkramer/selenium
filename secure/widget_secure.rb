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

  def test_widget
#login
    @driver.get "https://secure.shore.com/merchant/sign_in"
    @driver.find_element(:id, "merchant_account_email").clear
    @driver.find_element(:id, "merchant_account_email").send_keys "js@shore.com"
    @driver.find_element(:id, "merchant_account_password").clear
    @driver.find_element(:id, "merchant_account_password").send_keys "secret"
    @driver.find_element(:name, "button").click
    sleep 3
    verify { assert_equal "Shore - Manage your customers", @driver.title }
#Configuration
#check person count
@driver.get "https://secure.shore.com/merchant/bookings?appshell=true&merchant_profile_id=2f475a27-162b-4994-857f-399d6acf25ea"

sleep 2
checkbox = @driver.find_element(:id, "merchant_profile_config_attributes_required_capacity");
  if checkbox.selected?
      @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
          else
          checkbox.click
          @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            end

@driver.get "https://connect.shore.com/widget/testmerchant-qa"
sleep 4

verify { assert_include @driver.find_element(:css, "#requiredCapacityStep > div.step-content-wrapper > div.description").text, "Wählen Sie aus, für wie viele Personen der Termin gebucht werden soll." }
@driver.get "https://secure.shore.com/merchant/bookings?appshell=true&merchant_profile_id=2f475a27-162b-4994-857f-399d6acf25ea"

sleep 2
checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_required_capacity.boolean.optional");
            if checkbox.selected?
              @driver.find_element(:css, "input#merchant_profile_config_attributes_required_capacity.boolean.optional").click
              @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            else
              @driver.find_element(:css, "div.required-capacities > form.simple_form.form-horizontal > div.tile-footer > input.btn-blue").click
            end
            sleep 5
#Customers have to select the branch first
    @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
    sleep 5
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
    @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
    checkbox = @driver.find_element(:css, "#merchant_profile_key_account_attributes_newsletter_terms");
        if checkbox.selected?
          @driver.find_element(:css, "input.btn-blue").click
        else
          checkbox.click
        end
      @driver.find_element(:css, "input.btn-blue").click
      @driver.get "https://connect.shore.com/widget/testmerchant-qa"
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
      verify { assert_include @driver.find_element(:css, "div.form-row.widget-terms").text, "Im Falle der Buchung Ihres Termins nutzen wir Testmerchant # QA Ihre E-Mail-Adresse auch, um Sie per E-Mail über ähnliche Produkte oder Dienstleistungen aus unserem Sortiment zu informieren." }
#Inform customers about newsletter subscription off
      @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
      checkbox = @driver.find_element(:css, "#merchant_profile_key_account_attributes_newsletter_terms");
          if checkbox.selected?
            checkbox.click
            else
              @driver.find_element(:css, "input.btn-blue").click
            end
            @driver.find_element(:css, "input.btn-blue").click
      @driver.get "https://connect.shore.com/widget/testmerchant-qa"
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
      verify { assert_include @driver.find_element(:css, "div.form-row.widget-terms").text, "Mit dem Absenden des Formulars bestätige ich, dass ich die AGB von Shore gelesen und akzeptiert habe." }
#feeback shown
      @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
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
      @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
      checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_feedback_in_booking");
        if checkbox.selected?
            checkbox.click
            @driver.find_element(:css, "input.btn-blue").click
          else
              @driver.find_element(:css, "input.btn-blue").click
              end
      @driver.get "https://connect.shore.com/widget/testmerchant-qa"
      sleep 5
      @driver.get "https://secure.shore.com/merchant/widget?appshell=true"
      checkbox = @driver.find_element(:css, "input#merchant_profile_config_attributes_display_feedback_in_booking");
        if checkbox.selected?
          @driver.find_element(:css, "input.btn-blue").click
          else
            checkbox.click
            @driver.find_element(:css, "input.btn-blue").click
        end
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
