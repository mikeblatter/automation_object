# frozen_string_literal: true

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
        @top.active_screens.each do |screen_name, screen|
          paths[screen_name] = recursive_search(screen)
        end

        flattened_paths = flat_hash(paths).keys.sort_by(&:length)
        flattened_paths.each do |flattened_path|
          next unless flattened_path.last == @target

          return follow_route(flattened_path)
        end

        false
      end

      private

      def follow_route(flattened_path)
        flattened_path.each_with_index do |container_name, index|
          parent_name = index > 0 ? flattened_path[index - 1] : nil
          next_container_name = index < flattened_path.length ? flattened_path[index + 1] : nil

          container = container_by_key(container_name, parent_name)
          container.utilize

          return true unless next_container_name

          element = container.element_to_container(next_container_name)
          element_method = element.method_to_container(next_container_name)

          element_proxy = element.utilize

          case element
          when ElementArray
            element_proxy.sample.send(element_method) # grab random
          when ElementHash
            element_proxy[element_proxy.keys.sample].send(element_method)
          else
            element_proxy.send(element_method)
          end
        end

        false
      end

      def flat_hash(h, f = [], g = {})
        return g.update(f => h) unless h.is_a? Hash

        h.each { |k, r| flat_hash(r, f + [k], g) }
        g
      end

      # @param container [AutomationObject::State::Screen, AutomationObject::State::Modal]
      # @param depth [Integer]
      def recursive_search(container, depth = 0)
        return nil if depth >= MAX_RECURSION_DEPTH

        next_level = {}
        container.changes.each do |next_container_name|
          next if next_container_name == container.name

          if next_container_name == @target
            next_level[next_container_name] = nil
            return next_level
          end

          next_level[next_container_name] = recursive_search(container_by_key(next_container_name, container.name), depth + 1)
        end

        next_level
      end

      # @param container_name [Symbol]
      # @param parent_name [Symbol]
      # @return [AutomationObject::State::Screen, AutomationObject::State::Modal]
      def container_by_key(container_name, parent_name)
        return @top.screens[container_name] if @top.screens[container_name]

        @top.screens[parent_name].modals[container_name]
      end
    end
  end
end
