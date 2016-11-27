# Element Step Definitions

### Call an element method

#### Examples

* I click on the "home_screen" "about_button" element
* I hover over the "home_screen" "test_link" element
* I tap on "home_screen" "logo_button" element

#### Regex

```
^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$
```

---