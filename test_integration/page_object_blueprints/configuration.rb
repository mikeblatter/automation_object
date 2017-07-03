require_relative '../../lib/automation_object/page_object'

class Configuration < AutomationObject::PageObject::Configuration
  base_url('http://localhost:3000')
end