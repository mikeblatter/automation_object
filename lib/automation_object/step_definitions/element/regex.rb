module AutomationObject
  module StepDefinitions
    module Element
      #Storing regular expressions in a module
      #So I can unit test the matches and any changes that can occur to them
      #To make sure we don't break existing implementations by accident

      #Stores definition matches for elements
      module Regex
        #Actions
        CALL_METHOD = /^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

        TYPE_METHOD = /^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

        SCROLL_METHOD = /^I scroll to (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

        SAVE_METHOD = /^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/

        #Should

        EXIST_SHOULD = /^(?:the)? "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element should ?(n't |not )?exist$/

        EQUAL_SHOULD = /^(?:the)? "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(.+)"$/
      end
    end
  end
end