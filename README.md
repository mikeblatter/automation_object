# AutomationObject

https://travis-ci.org/mikeblatter/automation_object.svg?branch=master

Configuration based dynamic DSL framework for UI automation using Selenium or Appium drivers.

This gem provides a way to create a dynamic usable DSL framework representing your website or app. Implementing Selenium/Appium driver
and YAML configurations, this API will provide a layer in between your automation code and the driver.
By creating YAML configurations that represents your website/app, the DSL framework in turn will reflect your configuration
and allow you to control the automation through the DSL framework.  Using this gem can help remove tedious tasks that are often
repeated throughout code and help improve the scalability of code by mapping UI in YAML configuration files.

## Features

1. Creates a usable composite the automates interactions with UI
2. Use configurations to create tree hierarchies of a website or app

## Installation

```
gem install automation_object
```

## Public Interface Examples

```
require 'automation_object'

ao = AutomationObject::Framework.new(args)

ao.home_screen.contact_button.click
puts ao.contact_screen.

```

## Settings up Selenium/Chromedriver locally (Mac)

Downloads:

http://www.seleniumhq.org/download/ - Selenium Standalone
https://sites.google.com/a/chromium.org/chromedriver/ - Chrome driver

Edit following file:  ~/.bash_profile

Add the code for where you stored your various drivers. I usually put all my drivers in one folder and add it directly
to the path.

```
export SELENIUM_SERVER_JAR=/Users/yourusername/path/where/jar/is
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=/Users/yourusername/path/to/drivers:$PATH
```

Execute this command in your shell after you opened a new window or user session and make sure those variables are added
in the output.


```
printenv
```

