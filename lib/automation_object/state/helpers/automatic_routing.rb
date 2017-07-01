module AutomationObject
  module State
    class AutomaticRouting
      MAX_RECURSION_DEPTH = 10

      # @param top_state [AutomationObject::State::Top]
      # @param target [Symbol]
      def initialize(top_state, target)
        @top = top_state
        @target = target
      end

      # @return [Boolean] success or not
      def route
        paths = {}
        @top.active_screens.each { |screen_name, screen|
          paths[screen_name] = recursive_search(screen)
        }

        flattened_paths = flat_hash(paths).keys.sort_by(&:length)
        flattened_paths.each { |flattened_path|
          next unless flattened_path.last == @target
          return follow_route(flattened_path)
        }

        false
      end

      private

      def follow_route(flattened_path)
        flattened_path.each_with_index { |container_name, index|
          parent_name = (index > 0) ? flattened_path[index - 1] : nil

          container = container_by_key(container_name, parent_name)
          container.utilize
        }

        false
      end

      def flat_hash(h, f=[], g={})
        return g.update({ f => h }) unless h.is_a? Hash
        h.each { |k, r| flat_hash(r, f+[k], g) }
        g
      end

      # @param container [AutomationObject::State::Screen, AutomationObject::State::Modal]
      # @param depth [Integer]
      def recursive_search(container, depth = 0)
        return nil if depth >= MAX_RECURSION_DEPTH

        next_level = {}
        container.changes.each { |next_container_name|
          next if next_container_name == container.name

          if next_container_name == @target
            next_level[next_container_name] = nil
            return next_level
          end

          next_level[next_container_name] = recursive_search(container_by_key(next_container_name, container.name), depth + 1)
        }

        next_level
      end

      # @param container_name [Symbol]
      # @param parent_name [Symbol]
      # @return [AutomationObject::State::Screen, AutomationObject::State::Modal]
      def container_by_key(container_name, parent_name)
        return @top.screens[container_name] if @top.screens[container_name]
        return @top.screens[parent_name].modals[container_name]
      end
    end
  end
end
