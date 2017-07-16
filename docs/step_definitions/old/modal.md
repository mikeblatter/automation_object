# Modal Step Definitions

### Automatically navigate to a modal

#### Examples

* I go to the "login_screen" "test_modal" modal
* I go to "home_screen" "test_modal" modal

#### Regex

```
^I go to (?:the |)"([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal$
```

---

### Test if modal is currently active

#### Examples

* the "home_screen" "test_modal" modal should be active
* the "login_screen" "test_modal" modal shouldn't be active

#### Regex

```
^the "([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal should ?(n't |not )?be active$
```