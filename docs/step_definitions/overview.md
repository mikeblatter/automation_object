# Cucumber Step Definitions Overview

## Loading Step Definitions in Cucumber

```
require 'automation_object'

# Will require step definitions
AutomationObject::StepDefinitions.load
```

I created a static function to load the cucumber steps because requiring steps outside a Cucumber context
causes exceptions to be raised. This way you can use AutomationObject in many contexts

## Step Definitions

- [Screen Step Definitions](screen.md)
- [Element Array Step Definitions](element_array.md)
- [Element Hash Step Definitions](element_hash.md)
- [Element Step Definitions](element.md)