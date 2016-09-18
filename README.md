# AutomationObject

[![Travis Master](https://travis-ci.org/mikeblatter/automation_object.svg?branch=master)](https://travis-ci.org/mikeblatter/automation_object/builds)

Configuration based dynamic DSL framework for UI automation using Selenium or Appium drivers.

This gem provides a way to create a dynamic usable DSL framework representing your website or app. Implementing Selenium/Appium driver
and YAML configurations, this API will provide a layer in between your automation code and the driver.
By creating YAML configurations that represents your website/app, the DSL framework in turn will reflect your configuration
and allow you to control the automation through the DSL framework.  Using this gem can help remove tedious tasks that are often
repeated throughout code and help improve the scalability of code by mapping UI in YAML configuration files.

## Currently In Development

Most of the features are unavailable and the gem is not supported at all right now. In the middle of building out most
of the core features/code.

## Features

1. Configurations represent the UI and structure of your site/app
2. Configuration will be used to generate a usable composite that automates UI interactions
3. Automatic validation of configuration inputs
4. Generated composite that operates the UI automation
5. Takes out extraneous automation code allowing you to operate purely with business logic
6. Cucumber pre-made step definitions
7. Encapsulates an entire layer of automation allowing for quick UI testing development
8. Configurations allow for DRY development

## Installation

```
gem install automation_object
```

## Fully working example

[Test Integration](/test_integration) contains examples for automation using AutomationObject. Fully contained
project with a Rails app so that testing AutomationBot can be done without running into issues 
like bot protection.

I included the needed drivers so it is mostly free of dependencies. Also created a mac_osx.sh script contained
that helps install any base programs you may need. If you want to do it manually can follow the script
and download those components or use whatever you have.

## Example Configuration YAML file

```
# Example, doesn't actually work
base_url: http://www.google.com
screens:
  home_screen:
    elements:
      search_input:
        xpath: '//input[@id="search_input]'
        submit:
          after:
            change_screen: 'search_screen'
      search_button:
        css: '#search_button'
        click:
          after:
            wait_for_elements:
              - element_name: 'loading_spinner'
                visible?: false
            change_screen: 'search_screen'
      loading_spinner:
        css: '#loading_spinner'
  search_screen:
    load:
      live?:
        - element_name: 'search_results'
          exists?: true
    elements:
      home_button:
        xpath: '//button[@id="home"]'
        click:
          after:
            change_screen: 'home_screen'
      search_results:
        css: '#search_results'
```

## Public Interface Example

```
require 'automation_object'

ao = AutomationObject::Framework.new(args)

ao.home_screen.search_input.send_keys('automation_object gem')
ao.home_screen.search_button.click # Now moving to search screen

# Go back to home screen
ao.search_screen.home_screen.click

# Search Again

ao.home_screen.search_input.send_keys('automation_object gem')
ao.home_screen.search_input.submit # On search_screen again

```
