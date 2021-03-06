# frozen_string_literal: true

# Require public page object classes for inheriting
require_relative 'page_object/configuration'
require_relative 'page_object/screen'
require_relative 'page_object/modal'
require_relative 'page_object/hook'
require_relative 'page_object/hook_action'
require_relative 'page_object/element'
require_relative 'page_object/element_array'
require_relative 'page_object/element_hash'

module AutomationObject
  # Public interface for PageObject
  module PageObject
  end
end
