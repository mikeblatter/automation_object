# require_relative '../../../test_helper'
# require_relative '../../../../lib/automation_object/driver/helpers/selenium_element_helper'
#
# #TODO, review
# #Test AutomationObject::Driver::SeleniumElementHelper module
# class TestSeleniumElementHelper < Minitest::Test
#   def setup
#     @object = Object.new
#     @object.extend(AutomationObject::Driver::SeleniumElementHelper)
#   end
#
#   def set_element_subject(subject)
#     @object.instance_variable_set(:@subject, subject)
#   end
#
#   def set_driver_subject(subject)
#     @object.instance_variable_set(:@driver, subject)
#   end
#
#   def test_x
#     element = stub(:location => stub(:x => 5))
#     self.set_element_subject(element)
#
#     assert_equal 5, @object.x
#   end
#
#   def test_y
#     element = stub(:location => stub(:y => 5))
#     self.set_element_subject(element)
#
#     assert_equal 5, @object.y
#   end
#
#   def test_width
#     element = stub(:size => stub(:width => 5))
#     self.set_element_subject(element)
#
#     assert_equal 5, @object.width
#   end
#
#   def test_height
#     element = stub(:size => stub(:height => 5))
#     self.set_element_subject(element)
#
#     assert_equal 5, @object.height
#   end
#
#   def test_visible?
#     element = stub(:displayed? => true)
#     self.set_element_subject(element)
#
#     assert_equal true, @object.visible?
#
#     element = stub(:displayed? => false)
#     self.set_element_subject(element)
#
#     assert_equal false, @object.visible?
#   end
#
#   def test_invisible?
#     element = stub(:displayed? => true)
#     self.set_element_subject(element)
#
#     assert_equal false, @object.invisible?
#
#     element = stub(:displayed? => false)
#     self.set_element_subject(element)
#
#     assert_equal true, @object.invisible?
#   end
#
#   def test_id
#     element = stub
#     element.expects(:attribute).with('id').returns('test_id')
#     self.set_element_subject(element)
#
#     assert_equal 'test_id', @object.id
#   end
#
#   def test_href
#     element = stub
#     element.expects(:attribute).with('href').returns('test_href')
#     self.set_element_subject(element)
#
#     assert_equal 'test_href', @object.href
#   end
#
#   def test_content
#     element = stub
#     element.expects(:attribute).with('content').returns('test_content')
#     self.set_element_subject(element)
#
#     assert_equal 'test_content', @object.content
#   end
#
#   def test_attribute
#     element = stub
#     element.expects(:attribute).with('test_attribute').returns('test_value')
#     self.set_element_subject(element)
#
#     assert_equal 'test_value', @object.attribute('test_attribute')
#   end
#
#   def test_attribute_set
#     element = stub
#     element.expects(:attribute).with('test_attribute').returns('test_value')
#     self.set_element_subject(element)
#
#     driver = stub
#     driver.expects(:execute_script).with("return arguments[0].test_attribute = 'test_value'", element)
#     self.set_driver_subject(driver)
#
#     assert_equal 'test_value', @object.attribute('test_attribute', 'test_value')
#   end
#
#   def test_get_element_center
#     location_struct = OpenStruct.new(:x => rand(0..100), :y => rand(0..100))
#     size_struct = OpenStruct.new(:width => rand(0..100), :height => rand(0..100))
#
#     element = stub(:location => location_struct, :size => size_struct)
#     self.set_element_subject(element)
#
#     element_x = location_struct.x.to_f + size_struct.width.to_f * 0.5
#     element_y = location_struct.y.to_f + size_struct.height.to_f * 0.5
#
#     element_center = @object.element_center
#
#     assert_equal element_x, element_center.x
#     assert_equal element_y, element_center.y
#   end
#
#   def test_box_coordinates
#     location_struct = OpenStruct.new(:x => rand(0..100), :y => rand(0..100))
#     size_struct = OpenStruct.new(:width => rand(0..100), :height => rand(0..100))
#
#     element = stub(:location => location_struct, :size => size_struct)
#     self.set_element_subject(element)
#
#     box_coordinates = @object.box_coordinates
#
#     assert_equal location_struct.x, box_coordinates.x1
#     assert_equal location_struct.y, box_coordinates.y1
#     assert_equal (location_struct.x + size_struct.width), box_coordinates.x2
#     assert_equal (location_struct.y + size_struct.height), box_coordinates.y2
#   end
#
#   #TODO: finish, working on the easier unit tests right now
#   def test_collides_with_element?
#
#   end
#
#   def test_hover
#     element = stub
#     self.set_element_subject(element)
#
#     driver = mock()
#     action = mock()
#     move_to = mock()
#
#     move_to.expects(:perform).once
#     action.expects(:move_to).with(element).once.returns(move_to)
#     driver.expects(:action).once.returns(action)
#
#     self.set_driver_subject(driver)
#
#     #scroll_into_view is specialized for Appium/Selenium in their adapter folders
#     @object.expects(:scroll_into_view).returns(nil)
#     @object.hover
#   end
#
#   def test_switch_to_iframe
#     @object.expects(:iframe_switch_value => 'test_iframe_value')
#
#     driver = mock()
#     switch_to = mock()
#
#     switch_to.expects(:frame).with('test_iframe_value').returns(nil).once
#     driver.expects(:switch_to).returns(switch_to).once
#
#     self.set_driver_subject(driver)
#
#     @object.switch_to_iframe
#   end
#
#   #TODO: finish
#   def test_iframe_switch_value
#
#   end
# end