# Element_array Step Definitions

## Steps: 

### For: Call an element array method
 
#### Examples: 

*  I click on a random "home_screen" "about_button" element array

*  I click on 0..9 "home_screen" "menu_modal" "about_button" element array

*  I click on 0..9 "home_screen" "about_button" element array

*  I hover over all "home_screen" "about_button" element array

*  I click on the first "home_screen" "about_button" element array


#### Regex: 

 ```
^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$
```

----

### For: Type into element array field
 
#### Examples: 

*  I type "blah" into the first "home_screen" "menu_modal" "text_field" element array

*  I type "blah" into the first "home_screen" "text_field" element array


#### Regex: 

 ```
^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$
```

----

### For: Scroll element array item(s) into focus
 
#### Examples: 

*  I scroll to the first "home_screen" "menu_modal" "logo_button" element array

*  I scroll to the first "home_screen" "logo_button" element array


#### Regex: 

 ```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$
```

----

### For: Save value from element array for use later
 
#### Examples: 

*  I save "text" as "unique_value" from the first "home_screen" "menu_modal" "logo_button" element array

*  I save "text" as "unique_value" from the first "home_screen" "logo_button" element array


#### Regex: 

 ```
^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$
```

----

### For: Test the element arrays length
 
#### Examples: 

*  the "home_screen" "menu_modal" "title" element array should be greater than 0

*  the "home_screen" "title" element array should be greater than 0


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
```

----

### For: Test if the element method value equals a given value
 
#### Examples: 

*  the all "home_screen" "title" element array "text" should not equal "Home"

*  the 0..9 "home_screen" "title" element array "text" should equal "Home"

*  the random "home_screen" "menu_modal" "title" element array "text" should not equal "Home"

*  the random "home_screen" "title" element array "text" should not equal "Home"

*  the last "home_screen" "title" element array "text" shouldn't equal "Home"

*  the first "home_screen" "title" element array "text" should equal "Home"


#### Regex: 

 ```
^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should?(n't| not)? equal "(\w+|%\{\w+\})"$
```

----

### For: Test if the element arrays is unique
 
#### Examples: 

*  the "home_screen" "title" element array "text" shouldn't be unique

*  the "home_screen" "menu_modal" "title" element array "text" should not be unique

*  the "home_screen" "title" element array "text" should not be unique

*  the "home_screen" "title" element array "text" should be unique


#### Regex: 

 ```
^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should(n't| not)? be unique$
```

----

