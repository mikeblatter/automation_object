# Element Array Step Definitions

Provides step definitions related to element arrays



## Table of Contents

- [Calling an element array method](#callinganelementarraymethod)
- [Typing into element array field](#typingintoelementarrayfield)
- [Scrolling element array item(s) into focus](#scrollingelementarrayitemsintofocus)
- [Saving value from element array for use later](#savingvaluefromelementarrayforuselater)
- [Testing the element arrays size](#testingtheelementarrayssize)
- [Testing if the element method value equals a given value](#testingiftheelementmethodvalueequalsagivenvalue)
- [Testing if the element arrays uniqueness](#testingiftheelementarraysuniqueness)

## Steps 



### Calling an element array method

#### Examples

- I click on the first "home_screen" "about_button" element array
- I hover over all "home_screen" "about_button" element array
- I click on 0..9 "home_screen" "about_button" element array
- I click on a random "home_screen" "about_button" element array


#### Regex

```^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$```




### Typing into element array field

#### Examples

- I type "blah" into the first "home_screen" "text_field" element array


### Scrolling element array item(s) into focus

#### Examples

- I scroll to the first "home_screen" "logo_button" element array


### Saving value from element array for use later

#### Examples

- I save "text" as "unique_value" from the first "home_screen" "logo_button" element array


### Testing the element arrays size

#### Examples

- the "home_screen" "title" element array should be greater than 0


### Testing if the element method value equals a given value

#### Examples

- the first "home_screen" "title" element array "text" should equal "Home"
- the last "home_screen" "title" element array "text" shouldn't equal "Home"
- the random "home_screen" "title" element array "text" should not equal "Home"
- the 0..9 "home_screen" "title" element array "text" should equal "Home"
- the all "home_screen" "title" element array "text" should not equal "Home"


### Testing if the element arrays uniqueness

#### Examples

- the "home_screen" "title" element array "text" should be unique
- the "home_screen" "title" element array "text" should not be unique
- the "home_screen" "title" element array "text" shouldn't be unique
