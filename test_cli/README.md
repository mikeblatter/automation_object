# Test Command README

A more complete hands-on test for automation_object, to assist in development.

Test will launch a interactive CLI to test the DSL structure and it's interactions with the website.
A local rails server will launch on 3024, blue prints of the website are located in this directory.

## Requirements

1. Gem dependencies 
2. Selenium and drivers exported to your profile

## Command for Interactive CLI

```
ruby main.rb cli --trace
```

### Example CMDs

Runs ruby eval on input given

```
ao.home_screen.logo_button
puts 'test'
```

## Command for Cucumber Tests

```
ruby main.rb cucumber --trace
```