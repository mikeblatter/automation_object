# Element Step Definitions

## Steps: 

### Call an element method
 
#### Examples: 

*  I tap on "home_screen" "logo_button" element

*  I hover over the "home_screen" "menu_modal" "test_link" element

*  I hover over the "home_screen" "test_link" element

*  I click on the "home_screen" "about_button" element


#### Regex: 

 ```
^I (\w+|%\{\w+\}) ?(?: on| over)? (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$
```

----

### Type into element field
 
#### Examples: 

*  I type "blah" in "home_screen" "text_field" element

*  I type "test" in the "home_screen" "menu_modal" "text_field" element

*  I type "test" in the "home_screen" "text_field" element

*  I type "blah" into the "home_screen" "text_field" element


#### Regex: 

 ```
^I type "([^"]+|%\{\w+\})" in(?:to)? (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$
```

----

### Scroll element into focus
 
#### Examples: 

*  I scroll to "home_screen" "menu_modal" "logo_button" element

*  I scroll to "home_screen" "logo_button" element

*  I focus to the "home_screen" "logo_button" element

*  I scroll to the "home_screen" "logo_button" element


#### Regex: 

 ```
^I (?:scroll |focus )to (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$
```

----

### Save value from element for use later
 
#### Examples: 

*  I save "id" as "unique_value" from "home_screen" "menu_modal" "logo_button" element

*  I save "id" as "unique_value" from "home_screen" "logo_button" element

*  I save "text" as "unique_value" from the "home_screen" "logo_button" element


#### Regex: 

 ```
^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$
```

----

### Test if the element exists or not
 
#### Examples: 

*  "home_screen" "menu_modal" "title" element should not exist

*  "home_screen" "title" element should not exist

*  the "home_screen" "title" element shouldn't exist

*  the "home_screen" "title" element should exist


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element should ?(n't |not )?exist$
```

----

### Test if the element method value equals a given value
 
#### Examples: 

*  the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"

*  "home_screen" "menu_modal" "title" element "text" should not equal "About"

*  "home_screen" "title" element "text" should not equal "About"

*  the "home_screen" "title" element "text" should equal "Home"


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element "(\w+|%\{\w+\})" should ?(n't |not )?equal "(\w+|%\{\w+\})"$
```

----

