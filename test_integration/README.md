# Test Command README

A more complete hands-on test for automation_object, to assist in development.

Test will launch a interactive CLI to test the DSL structure and it's interactions with the website.
A local rails server will launch on 3024, blue prints of the website are located in this directory.

## Requirements

1. Gem dependencies 
2. Selenium and drivers exported to your profile

## Command for Interactive CLI

Examples will run interactive command line that allows you to type ruby code into the command line
and print out the output

* Full Rails Example with AutomationObject
```
ruby full_example.rb
```

* Selenium Driver example only
```
ruby selenium_driver.rb
```

## Command for Cucumber Tests

```
cucumber
```

## Drivers

- ChromeDriver: v2.25
- Selenium: v2.53.1