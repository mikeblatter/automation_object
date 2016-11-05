# Element Step Definitions

Provides step definitions related to elements



## Table of Contents

- Calling an element method
- Typing into element field
- Scrolling element into focus
- Saving value from element for use later
- Testing if the element exists or not
- Testing if the element method value equals a given value

## Steps 

--- 

### Calling an element method

#### Examples

- I click on the "home_screen" "about_button" element
- I hover over the "home_screen" "test_link" element
- I tap on "home_screen" "logo_button" element


#### Regex

```^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$```


--- 

### Typing into element field

#### Examples

- I type "blah" into the "home_screen" "text_field" element
- I type "test" in the "home_screen" "text_field" element
- I type "blah" in "home_screen" "text_field" element


#### Regex

```^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$```


--- 

### Scrolling element into focus

#### Examples

- I scroll to the "home_screen" "logo_button" element
- I focus to the "home_screen" "logo_button" element
- I scroll to "home_screen" "logo_button" element


#### Regex

```^I (?:scroll |focus )to (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$```


--- 

### Saving value from element for use later

#### Examples

- I save "text" as "unique_value" from the "home_screen" "logo_button" element
- I save "id" as "unique_value" from "home_screen" "logo_button" element


#### Regex

```^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$```


--- 

### Testing if the element exists or not

#### Examples

- the "home_screen" "title" element should exist
- the "home_screen" "title" element shouldn't exist
- "home_screen" "title" element should not exist


#### Regex

```^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element should ?(n't |not )?exist$```


--- 

### Testing if the element method value equals a given value

#### Examples

- the "home_screen" "title" element "text" should equal "Home"
- "home_screen" "title" element "text" should not equal "About"
- the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"


#### Regex

```^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$```


