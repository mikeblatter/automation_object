# frozen_string_literal: true
require_relative '../driver'

module AutomationObject
  module Driver
    module CommonSelenium
      # Helper module for Selenium based elements
      module ElementGeometry
        # @return [Numeric] x position of element
        def x
          @subject.location.x
        end

        # @return [Numeric] y position of element
        def y
          @subject.location.y
        end

        # @return [Numeric] width of element
        def width
          @subject.size.width
        end

        # @return [Numeric] height of element
        def height
          @subject.size.height
        end

        # Get the location
        # @return [Point]
        def location
          @subject.location
        end

        # Get the size of an element
        # @return [Dimension]
        def size
          @subject.size
        end

        # @return [Hash] :x, :y coordinates
        def element_center
          element_location = @subject.location
          element_size = @subject.size

          center = Point.new
          center.x = (element_location.x.to_f + element_size.width.to_f / 2).to_f
          center.y = (element_location.y.to_f + element_size.height.to_f / 2).to_f

          center
        end

        # @return [BoxCoordinates] :x1, :x2, :y1, :y2 coordinates of a box
        def box_coordinates
          element_location = @subject.location
          element_size = @subject.size

          box_coordinates = BoxCoordinates.new
          box_coordinates.x1 = element_location.x.to_f
          box_coordinates.y1 = element_location.y.to_f
          box_coordinates.x2 = element_location.x.to_f + element_size.width.to_f
          box_coordinates.y2 = element_location.y.to_f + element_size.height.to_f

          box_coordinates
        end

        # @param second_element_object [Object] element to compare to
        # @param collision_tolerance [Numeric] pixel tolerance of collisions
        # @return [Boolean] element collides with other
        def collides_with_element?(second_element_object, collision_tolerance = 0)
          box_one = box_coordinates
          box_two = second_element_object.box_coordinates

          if box_one.x2 > box_two.x1 && box_one.x1 < box_two.x2 && box_one.y2 > box_two.y1 && box_one.y1 < box_two.y2
            if box_one.x2 > (box_two.x1 + collision_tolerance) && (box_one.x1 + collision_tolerance) < box_two.x2 &&
               box_one.y2 > (box_two.y1 + collision_tolerance) && (box_one.y1 + collision_tolerance) < box_two.y2
              return true
            end
          end

          false
        end
      end
    end
  end
end
