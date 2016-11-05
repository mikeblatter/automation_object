# Screen Step Definitions

Provides step definitions related to screens



## Table of Contents

- Close the current screen or given screen
- Navigating back on a given or current screen
- Switch/Focus screen
- Setting the current screen's width or given screen

## Steps 

--- 

### Close the current screen or given screen

#### Examples

- I close the "contact" screen
- I close the screen
- I destroy the screen


#### Regex

```%r(^I (?:close|destroy) the ("([\w\s]+|%\{[\w\d]+\})")? ?screen$```


--- 

### Navigating back on a given or current screen

#### Examples

- I navigate back on the screen
- I navigate back on the "contact" screen


#### Regex

```%r(^I (?:navigate|go) back (?:on )?(?:the )?("([\w\s]+|%\{[\w\d]+\})")? ?screen$```


--- 

### Switch/Focus screen

#### Examples

- I switch to the "home" screen
- I focus the "contact" screen


#### Regex

```%r(^I (?:switch|focus) (?:to )?(?:the )?"([\w\s]+|%\{[\w\d]+\})" screen$```


--- 

### Setting the current screen's width or given screen

#### Examples

- I set the screen size to 1000x2000
- I set the "home" screen size to 1000x2000
- I set the screen width to 1000
- I set the screen height to 2000


#### Regex

```%r(^I set the ("([\w\s]+|%\{[\w\d]+\})")? ?screen (size|width|height) to (\d+|(\d+)x(\d+))$```

