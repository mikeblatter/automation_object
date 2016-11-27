# Cucumber Step Definitions Overview

## MiniTest - For Assertions

I chose to use [MiniTest](https://github.com/seattlerb/minitest) as the testing suite because I was already 
using it for unit testing the gem itself. Figured it would be easier to move back and forth. If there is a good
case for changing it to RSpec/etc..., I'm open to it.

## Loading Step Definitions in Cucumber

```
require 'automation_object'

# Will require step definitions
AutomationObject::StepDefinitions.load
```

I created a static function to load the cucumber steps because requiring steps outside a Cucumber context
causes exceptions to be raised.

## Step Definitions

- [Screen Step Definitions](screen.md)
- [Modal Step Definitions](modal.md)
- [Element Array Step Definitions](element_array.md)
- [Element Hash Step Definitions](element_hash.md)
- [Element Step Definitions](element.md)