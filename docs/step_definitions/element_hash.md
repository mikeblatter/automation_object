# Element Hash Step Definitions

Provides step definitions related to element hashes



## Table of Contents

- (Calling an element hash method)[Calling an element hash method]
- (Typing into element hash field)[Typing into element hash field]
- (Scrolling element hash item(s) into focus)[Scrolling element hash item(s) into focus]
- (Saving value from element hash for use later)[Saving value from element hash for use later]
- (Testing the element hashes size)[Testing the element hashes size]
- (Testing if the element hash value equals a given value)[Testing if the element hash value equals a given value]
- (Testing if the element hashes uniqueness)[Testing if the element hashes uniqueness]

## Steps 



### Calling an element hash method

#### Examples

- I click on the first "home_screen" "about_button" element hash


#### Regex

```^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash```




### Typing into element hash field

#### Examples

- I type "blah" into the first "home_screen" "text_field" element hash


#### Regex

```^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash```




### Scrolling element hash item(s) into focus

#### Examples

- I scroll to the first "home_screen" "logo_button" element hash


#### Regex

```^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash```




### Saving value from element hash for use later

#### Examples

- I save "text" as "unique_value" from the first "home_screen" "logo_button" element hash


#### Regex

```^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash```




### Testing the element hashes size

#### Examples

- the "home_screen" "title" element hash should be greater than 0


#### Regex

```^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$```




### Testing if the element hash value equals a given value

#### Examples

- the first "home_screen" "title" element hash "text" should equal "Home"


#### Regex

```^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$```




### Testing if the element hashes uniqueness

#### Examples

- the "home_screen" "title" element hash "text" should be unique


#### Regex

```^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element hash "([\w\d]+|%\{[\w\d]+\})" should(n't|not)? be unique$```


