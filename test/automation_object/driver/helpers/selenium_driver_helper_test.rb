require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/driver/helpers/selenium_driver_helper'

#TODO, review
#Test AutomationObject::Driver::SeleniumDriverHelper module
class TestSeleniumDriverHelper < Minitest::Test
  def setup
    @object = Object.new
    @object.extend(AutomationObject::Driver::SeleniumDriverHelper)

    @driver_mock = Minitest::Mock.new
    @object.instance_variable_set(:@subject, @driver_mock)
  end

  def set_driver_subject(subject)
    @object.instance_variable_set(:@subject, subject)
  end

  def test_inner_window_height
    @driver_mock.expect :execute_script, 5, ['return window.innerHeight;']
    assert_equal @object.inner_window_height, 5
    @driver_mock.verify
  end

  def test_scroll_position_get
    position_struct = OpenStruct.new(:x => 5, :y => 5)

    @driver_mock.expect :execute_script, position_struct.x,
                        ['var doc = document.documentElement; return (window.pageXOffset || doc.scrollLeft) - (doc.clientLeft || 0);']
    @driver_mock.expect :execute_script, position_struct.y,
                        ['var doc = document.documentElement; return (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);']

    assert_equal @object.scroll_position, position_struct
    @driver_mock.verify
  end

  def test_scroll_position_set
    position = {:x => 5, :y => 5}
    @driver_mock.expect :execute_script, nil, ["window.scroll(#{position[:x]},#{position[:y]});"]

    @object.scroll_position = position
    @driver_mock.verify
  end

  def test_window_size_get
    size_struct = OpenStruct.new(:width => 1024, :height => 800)
    driver = stub(:manage => stub(:window => stub(:size => size_struct.clone)))
    self.set_driver_subject(driver)

    assert_equal size_struct, @object.window_size
  end

  def test_window_size_set
    size_struct = OpenStruct.new(:width => 1024, :height => 800)
    driver = stub(:manage => stub(:window => stub(:resize_to => Object.new)))
    driver.manage.window.expects(:resize_to).with(size_struct.width, size_struct.height)
    self.set_driver_subject(driver)

    @object.window_size = size_struct
  end

  def test_maximize_window
    driver = stub(:manage => stub(:window => stub(:maximize => Object.new)))
    driver.manage.window.expects(:maximize)
    self.set_driver_subject(driver)

    @object.maximize_window
  end
end