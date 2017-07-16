# Modal Step Definitions

## Steps: 

### Automatically navigate to the modal
 
#### Examples: 

*  I go to "login_screen" "test_modal" modal

*  I go to the "home_screen" "test_modal" modal


#### Regex: 

 ```
^I go to (?:the |)"([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal$
```

----

### Test if modal is currently active
 
#### Examples: 

*  the "login_screen" "test_modal" modal shouldn't be active

*  the "home_screen" "test_modal" modal should be active


#### Regex: 

 ```
^the "([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal should ?(n't |not )?be active$
```

----

