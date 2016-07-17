require_relative 'regex'

#Call method on an element

#Examples:
# I click on the "home_screen" "about_button" element
# I hover over the "home_screen" "test_link" element
# I tap on "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::Regex::CALL_METHOD) do |*args|
  #Parse args for any stored cache values
  method, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  #Call method
  AutomationObject::Framework.get.send(screen).send(element).send(method)
end

#Type into field element

# I type "blah" into the "home_screen" "text_field" element
# I hover over the "home_screen" "test_link" element
# I tap on "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::Regex::TYPE_METHOD) do |*args|
  #Parse args for any stored cache values
  text, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  #Call send_keys method and type text
  AutomationObject::Framework.get.send(screen).send(element).send_keys(text)
end

#Scroll element into view
When(AutomationObject::StepDefinitions::Element::Regex::SCROLL_METHOD) do |*args|
  #Parse args for any stored cache values
  screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  #Scroll element into view
  element = AutomationObject::Framework.get.send(screen).send(element)
  element.scroll_into_view
end

#Save something from an element
When(AutomationObject::StepDefinitions::Element::Regex::SAVE_METHOD) do |*args|
  #Parse args for any stored cache values
  method, key, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  #Save value from called method/property
  value = AutomationObject::Framework.get.send(screen).send(element).send(method)
  AutomationObject::StepDefinitions::Cache.set(key, value)
end