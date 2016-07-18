Feature: Testing cucumber steps in AutomationObject

  Scenario: Run through the available steps
    When I click on the "home_screen" "about_button" element
    Then I click on the "about_screen" "home_button" element
