# Element Array Step Definitions

### Call an element array method

#### Examples

* I click on the first "home_screen" "about_button" element array
* I hover over all "home_screen" "about_button" element array
* I click on 0..9 "home_screen" "about_button" element array
* I click on a random "home_screen" "about_button" element array

#### Regex

```
^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$
```

---

### Type into element array field

#### Examples

* I type "blah" into the first "home_screen" "text_field" element array

#### Regex

```
^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$
```

---

### Scroll element array item(s) into focus

#### Examples

* I scroll to the first "home_screen" "logo_button" element array

#### Regex

```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$
```

---

### Save value from element array for use later

#### Examples

* I save "text" as "unique_value" from the first "home_screen" "logo_button" element array

#### Regex

```
^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$
```

---

### Test the element arrays length

#### Examples

* the "home_screen" "title" element array should be greater than 0

#### Regex

```
^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
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
^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array "(\w+|%\{[\w\d]+\})" should?(n't| not)? equal "(\w+|%\{[\w\d]+\})"$
```

---

### Test if the element arrays is unique

#### Examples

* the "home_screen" "title" element array "text" should be unique
* the "home_screen" "title" element array "text" should not be unique
* the "home_screen" "title" element array "text" shouldn't be unique

#### Regex

```
^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element array "([\w\d]+|%\{[\w\d]+\})" should(n't| not)? be unique$
```