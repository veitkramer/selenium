Run terminal :
PATH=$PATH:. ruby log_in.rb

---------------------------

Pull down :
Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "variables.salutation")).select_by(:text, "Sehr geehrter Kunde,")

---------------------------

Enter text click enter :
.sendKeys "Some text"; element.sendKeys (Keys.ENTER)

---------------------------

Find text :
assert(@driver.find_element(:css => "h5.status-headline").text.include?("Ihr Termin ist gebucht."),"Assertion Pass")
assert(@driver.find_element(:css => "h5.status-headline").text.include?("Ihr Termin ist gebucht."),"Assertion Failed")#


verify { assert_include @driver.find_element(:css, "   ").text, "  " }
verify { assert_equal @driver.find_element(:css, "   ").text, "  " }

verify { assert_not_include @driver.find_element(:id, " ").text, " " }
verify { assert_not_equal @driver.find_element(:id, " ").text, " " }

If Element is present do action if not do nothing:
if @driver.find_elements(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").size() > 0
   @driver.find_element(:css, "tbody.mtw-rows > tr:first-child > td:nth-of-type(3) > div.mtw-column-actions > button.btn.btn-icon.btn-sm > i").click
   @driver.find_element(:css, "button.btn.btn-danger.btn-sm").click
end

---------------------------

Login Class :
sign_in_page = Signin::Page.new(@client)
sign_in_page.visit
sign_in_page.sign_in(email: "js@shore.com", password: "secret")

---------------------------

Check text :
@driver.find_element(:id, "   ").text.include?('   ')

---------------------------

Checkbox :
checkbox = @driver.find_element(:css, "   ");
    if checkbox.selected?
      @driver.find_element(:css, "  ").click
      else
        checkbox.click
        end

---------------------------

Create Random String :

#{rand(36**10).to_s(36)}

#{rand('A'..'Z').to_a}

---------------------------

ID :
[id^=\"service_\"] > div.tile-list-item-actions > a.launch-service-popup

---------------------------

Move mouse :
element = @driver.find_element(:css, "div#resources.sortable.ui-sortable")
@driver.action.move_to(element).perform

---------------------------

Keyboard

@driver.action.send_keys(:enter).perform
@driver.action.send_keys(:control, :shift, "G").perform
accpet alert :
@driver.switch_to.alert.accept

---------------------------
Browser back :
@driver.navigate().back()

Browser Refresh :
@driver.navigate().refresh()

---------------------------

File upload :
driver.find_element(id: "Document_upload").send_keys("C:\\Users\\me\\Desktop\\my_file.txt")
driver.find_element(id: "save").click

#drag and drop actions :
el1 = driver.find_element(id: "some_id1")
el2 = driver.find_element(id: "some_id2")
driver.action.drag_and_drop(el1, el2).perform

---------------------------
rakefile
task :default do

  FileList ['Log_in.rb'].each { |file| ruby file }

end

---------------------------

def setup => Browser
  #@driver = Selenium::WebDriver.for :safari
  #@driver = Selenium::WebDriver.for :firefox
