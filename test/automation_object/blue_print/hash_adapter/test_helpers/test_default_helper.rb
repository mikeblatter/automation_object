#For testing default values of the hash adapter composite classes
module TestDefaultHelper
  def defaults_test(defaults, target_class)
    defaults.each { |method, value|
      if value.instance_of?(Class)
        assert_instance_of value, target_class.new.send(method)
      else
        assert_equal value, target_class.new.send(method)
      end
    }
  end
end