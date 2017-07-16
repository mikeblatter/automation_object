# Cucumber Step Definitions Overview

The following documentation will demonstrate how to use AutomationObject in a Ruby/Cucumber context.
We have created common step definitions that you can include for automating and testing a website or app.

## Features

* Using RSpec for Assertions

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