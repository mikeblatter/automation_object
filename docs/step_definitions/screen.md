# Screen Step Definitions

Use the following step definitions to interact with or test screens
## Steps: 

### Automatically navigate to the screen
 
#### Examples: 

*  I go to "login_screen" screen

*  I go to the "home_screen" screen


#### Regex: 

 ```
^I go to (?:the |)"([\w\s]+|%\{\w+\})" screen
```

----

### Close the current screen or given screen
 
#### Examples: 

*  I destroy the screen

*  I close the screen

*  I close the "contact" screen


#### Regex: 

 ```
^I (?:close|destroy) the ("([\w\s]+|%\{\w+\})")? ?screen$
```

----

### Navigate back on a given or current screen
 
#### Examples: 

*  I navigate back on the "contact" screen

*  I navigate back on the screen


#### Regex: 

 ```
^I (?:navigate|go) back (?:on )?(?:the )?("([\w\s]+|%\{\w+\})")? ?screen$
```

----

### Switch/Focus screen
 
#### Examples: 

*  I focus the "contact" screen

*  I switch to the "home" screen


#### Regex: 

 ```
^I (?:switch|focus) (?:to )?(?:the )?"([\w\s]+|%\{\w+\})" screen$
```

----

### Setting the current screen's width or given screen
 
#### Examples: 

*  I set the screen height to 2000

*  I set the screen width to 1000

*  I set the "home" screen size to 1000x2000

*  I set the screen size to 1000x2000


#### Regex: 

 ```
^I set the ("([\w\s]+|%\{\w+\})")? ?screen (size|width|height) to (\d+|(\d+)x(\d+))$
```

----

### Test if screen is currently active
 
#### Examples: 

*  the "login" screen shouldn't be active

*  the "home" screen should be active


#### Regex: 

 ```
^the "([\w\s]+|%\{\w+\})" screen should ?(n't |not )?be active$
```

----

