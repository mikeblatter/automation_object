module AutomationObject
  module StepDefinitions
    #Storing regular expressions in a module
    #So I can unit test the matches and any changes that can occur to them
    #To make sure we don't break existing implementations by accident
    module Element
      #Action

      CALL_REGEX = /^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

      TYPE_REGEX = /^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

      SCROLL_REGEX = /^I scroll to (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

      SAVE_REGEX = /^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

      #Should

      EXIST_REGEX = /^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element should ?(n't |not )?exist$/

      EQUAL_REGEX = /^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(.+)"$/
    end
  end
end