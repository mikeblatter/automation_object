# Element Hash Step Definitions

### Call an element hash method

#### Examples

#### Regex

```
^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash$
```

---

### Type into element hash field

#### Examples

#### Regex

```
^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash$
```

---

### Scroll element hash item(s) into focus

#### Examples

#### Regex

```
^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash$
```

---

### Save value from element hash for use later

#### Examples

#### Regex

```
^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash$
```

---

### Test the element hashes size

#### Examples

#### Regex

```
^(?:the )?"(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$
```

---

### Test if the element hash value equals a given value

#### Examples

#### Regex

```
^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should ?(n't |not )?equal "(\w+|%\{\w+\})"$
```

---

### Test if the element hash is unique

#### Examples

#### Regex

```
^(?:the )?"(\w+|%\{\w+\})" "(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should(n't|not)? be unique$
```