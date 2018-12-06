# AutomationObject

[![Travis Master](https://travis-ci.org/mikeblatter/automation_object.svg?branch=master)](https://travis-ci.org/mikeblatter/automation_object/builds)
[![Coverage Status](https://coveralls.io/repos/github/mikeblatter/automation_object/badge.svg?branch=master)](https://coveralls.io/github/mikeblatter/automation_object?branch=master)

Configuration based dynamic DSL framework for UI automation.

This framework takes your created UI configurations and translates that into a usable DSL framework composite 
representing your website. It encapsulates many UI automation problems, supports integration to many different drivers,
and has built in Cucumber step definitions to get your tests up and running quick. With this, you can create scalable 
automation tests quickly.

## NOTE: This is a alpha library

Portions of the project are still incomplete as well as testing. It is possible to use
cucumber steps, YAML/HASH configuration adapters, selenium/appium drivers

## Git branches/issues/etc...

Since this is just a personal project committing directly to master, not doing issues. 
If have more people using or contributing will formalize to whichever works for everyone

## Steps to Complete Before Beta

May add more steps in the future as I add more to the project

- [ ] XML driver and any additional test drivers (ie selenium)
- [ ] Page object configuration style classes for blueprints
- [ ] Complete integration testing/fixes with different drivers, inputs, tests
- [ ] Majority Completion of Unit Tests

## Features

* Supports Appium, Selenium, Nokogiri as drivers
* Encapsulates automation logic
* Translates UI configuration to descriptive/usable language
* Cucumber step definitions to get your tests up and running fast
* DRY UI test development

## Installation

```
gem install automation_object
```

## Generated Docs

1. [Code Documentation (YARD Generated)](https://mikeblatter.github.io/automation_object/docs/internal)
2. [RubyCritic Report](https://mikeblatter.github.io/automation_object/docs/rubycritic)

## Cucumber Step Definition Docs

There are a number of Cucumber step definitions available within this gem to help you UI test.

- [Overview](docs/step_definitions/README.md)
- [Screen Step Definitions](docs/step_definitions/screen.md)
- [Modal Step Definitions](docs/step_definitions/modal.md)
- [Element Array Step Definitions](docs/step_definitions/element_array.md)
- [Element Hash Step Definitions](docs/step_definitions/element_hash.md)
- [Element Step Definitions](docs/step_definitions/element.md)

## Fully working example

[Test Integration](/test_integration) contains examples for automation using AutomationObject. Fully contained
project with a Rails app so that testing AutomationBot can be done without running into issues 
like bot protection.

I included the needed drivers so it is mostly free of dependencies. Also created a mac_osx.sh script contained
that helps install any base programs you may need. If you want to do it manually can follow the script
and download those components or use whatever you have.
