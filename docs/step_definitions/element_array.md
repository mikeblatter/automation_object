# Element Array Step Definitions

### Call an element array method

#### Examples

* I click on the first "home_screen" "about_button" element array
* I hover over all "home_screen" "about_button" element array
* I click on 0..9 "home_screen" "about_button" element array
* I click on a random "home_screen" "about_button" element array

#### Regex

```
^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array$
```

---

### Type into element array field

#### Examples

* I type "blah" into the first "home_screen" "text_field" element array

#### Regex

```
^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array$
```

---

### Scroll element array item(s) into focus

#### Examples

* I scroll to the first "home_screen" "logo_button" element array

#### Regex

```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array$
```

---

### Save value from element array for use later

#### Examples

* I save "text" as "unique_value" from the first "home_screen" "logo_button" element array

#### Regex

```
^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array$
```

---

### Test the element arrays length

#### Examples

* the "home_screen" "title" element array should be greater than 0

#### Regex

```
^(?:the )?"(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
```

---

### Test if the element arrays method value equals a given value

#### Examples

* the first "home_screen" "title" element array "text" should equal "Home"
* the last "home_screen" "title" element array "text" shouldn't equal "Home"
* the random "home_screen" "title" element array "text" should not equal "Home"
* the 0..9 "home_screen" "title" element array "text" should equal "Home"
* the all "home_screen" "title" element array "text" should not equal "Home"

#### Regex

```
^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should?(n't| not)? equal "(\w+|%\{\w+\})"$
```

---

### Test if the element arrays is unique

#### Examples

* the "home_screen" "title" element array "text" should be unique
* the "home_screen" "title" element array "text" should not be unique
* the "home_screen" "title" element array "text" shouldn't be unique

#### Regex

```
^(?:the )?"(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should(n't| not)? be unique$
```