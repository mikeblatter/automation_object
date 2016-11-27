# Element Hash Step Definitions

### Call an element hash method

#### Examples

#### Regex

```
^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$
```

---

### Type into element hash field

#### Examples

#### Regex

```
^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$
```

---

### Scroll element hash item(s) into focus

#### Examples

#### Regex

```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$
```

---

### Save value from element hash for use later

#### Examples

#### Regex

```
^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$
```

---

### Test the element hashes size

#### Examples

#### Regex

```
^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
```

---

### Test if the element hash value equals a given value

#### Examples

#### Regex

```
^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$
```

---

### Test if the element hash is unique

#### Examples

#### Regex

```
^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element hash "([\w\d]+|%\{[\w\d]+\})" should(n't|not)? be unique$
```