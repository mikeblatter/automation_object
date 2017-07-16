# Element_hash Step Definitions

## Steps: 

### Call an element hash method
 
#### Examples: 

*  I click on the first "home_screen" "menu_modal" "about_button" element hash

*  I click on the first "home_screen" "about_button" element hash


#### Regex: 

 ```
^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$
```

----

### Type into element hash field
 
#### Examples: 

*  I type "blah" into the first "home_screen" "menu_modal" "text_field" element hash

*  I type "blah" into the first "home_screen" "text_field" element hash


#### Regex: 

 ```
^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$
```

----

### Scroll element hash item(s) into focus
 
#### Examples: 

*  I scroll to the first "home_screen" "menu_modal" "logo_button" element hash

*  I scroll to the first "home_screen" "logo_button" element hash


#### Regex: 

 ```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$
```

----

### Save value from element hash for use later
 
#### Examples: 

*  I save "text" as "unique_value" from the first "home_screen" "menu_modal" "logo_button" element hash

*  I save "text" as "unique_value" from the first "home_screen" "logo_button" element hash


#### Regex: 

 ```
^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$
```

----

### Test the element hashes size
 
#### Examples: 

*  the "home_screen" "menu_modal" "title" element hash should be greater than 0

*  the "home_screen" "title" element hash should be greater than 0


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
```

----

### Test if the element hash value equals a given value
 
#### Examples: 

*  the first "home_screen" "menu_modal" "title" element hash "text" should equal "Home"

*  the first "home_screen" "title" element hash "text" should equal "Home"


#### Regex: 

 ```
^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should ?(n't |not )?equal "(\w+|%\{\w+\})"$
```

----

### Test if the element hash is unique
 
#### Examples: 

*  the "home_screen" "menu_modal" "title" element hash "text" should be unique

*  the "home_screen" "title" element hash "text" should be unique


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should(n't|not)? be unique$
```

----

