# Modal Step Definitions

### Test if modal is currently active

#### Examples

* the "home_screen" "test_modal" modal should be active
* the "login_screen" "test_modal" modal shouldn't be active

#### Regex

```
^the "([\w\s]+|%\{[\w\d]+\})" "([\w\s]+|%\{[\w\d]+\})" modal should ?(n't |not )?be active$
```