# AutomationObject

Configuration based dynamic DSL framework for UI automation using Selenium or Appium drivers.

This gem provides a way to create a dynamic usable DSL framework representing your website or app. Implementing Selenium/Appium driver
and YAML configurations, this API will provide a layer in between your automation code and the driver.
By creating YAML configurations that represents your website/app, the DSL framework in turn will reflect your configuration
and allow you to control the automation through the DSL framework.  Using this gem can help remove tedious tasks that are often
repeated throughout code and help improve the scalability of code by mapping UI in YAML configuration files.

## Work In Progress

This is still very much a work in progress and is not complete. Currently using this project as an experiment in design patterns
and exploration of Ruby code. Will update README as I progress and create the gem in rubygems.org when the majority of it is done
and stable.

## Settings up Selenium/Chromedriver locally

Edit your shell profile, typically for mac users ~/.bash_profile

```
export SELENIUM_SERVER_JAR=/Users/yourusername/path/where/jar/is
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=/Users/yourusername/path/to/drivers:$PATH
```

To test this, open a new shell session. You should see the variables in the output from the following command:

```
printenv
```

