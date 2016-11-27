Feature: Testing cucumber steps in AutomationObject

  Scenario: Run through the available steps
    When I click on the "home_screen" "contact_button" element
    Then the "contact_screen" screen should be active
    When I click on the "contact_screen" "home_button" element
    Then the "home_screen" screen should be active
    And the "home_screen" "menu_modal" modal shouldn't be active