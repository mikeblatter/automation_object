#Call method on an element
When(/^I (\w+) ?(?: on| over)? (?:the )?"(\w+)" "(\w+)" element$/) do |method, screen_name, element_name|
  AutomationObject::Framework.get.send(screen_name).send(element_name).send(method)
end

#Type into field element
When(/^I type "(\w+)" into "(\w+)" "(\w+)" element$/) do |text, screen_name, element_name|
  AutomationObject::Framework.get.send(screen_name).send(element_name).send_keys(text)
end

#Scroll element into view
When(/^I scroll "(.*?)" "(.*?)" into view$/) do |screen_name, element_name|
  element = AutomationObject::Framework.get.send(screen_name).send(element_name)
  element.scroll_to_view
end