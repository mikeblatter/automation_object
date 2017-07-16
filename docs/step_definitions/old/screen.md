# Screen Step Definitions

### Automatically navigate to a screen

#### Examples

* I go to the "login_screen" screen
* I go to "home_screen" screen

#### Regex

```
^I go to (?:the |)"([\w\s]+|%\{\w+\})" screen
```

---

### Close the current screen or given screen

#### Examples

* I close the "contact" screen
* I close the screen
* I destroy the screen

#### Regex

```
^I (?:close|destroy) the ("([\w\s]+|%\{\w+\})")? ?screen$
```

---

### Navigate back on a given or current screen

#### Examples

* I navigate back on the screen
* I navigate back on the "contact" screen

#### Regex

```
^I (?:navigate|go) back (?:on )?(?:the )?("([\w\s]+|%\{\w+\})")? ?screen$
```

---

### Switch/Focus screen

* I switch to the "home" screen
* I focus the "contact" screen

#### Examples

#### Regex

```
^I (?:switch|focus) (?:to )?(?:the )?"([\w\s]+|%\{\w+\})" screen$
```

---

### Set the current screen's width or given screen

#### Examples

* I set the screen size to 1000x2000
* I set the "home" screen size to 1000x2000
* I set the screen width to 1000
* I set the screen height to 2000

#### Regex

```
^I set the ("([\w\s]+|%\{\w+\})")? ?screen (size|width|height) to (\d+|(\d+)x(\d+))$
```

---

### Test if screen is currently active

#### Examples

* the "home" screen should be active
* the "login" screen shouldn't be active

#### Regex

```
^the "([\w\s]+|%\{\w+\})" screen should ?(n't |not )?be active$
```