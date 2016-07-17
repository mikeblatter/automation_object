#Call method on an element
When(/^I (\w+) ?(?: on| over)? (?:the )?"(\w+)" "(\w+)" element$/) do |method, screen_name, element_name|
  AutomationObject::Framework.get.send(screen_name).send(element_name).send(method)
end