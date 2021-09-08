module SolidusCrm
  module Event
    class Order < Base
      def initialize(order, event, from_event, to_event)
        @order = order
        @event = event
        @from_event = from_event
        @to_event = to_event
      end

      def emit
        SolidusCrm::Connection.post(
          endpoint,
          Rabl::Renderer.json(
            @order,
            template,
            view_path: view_path,
            scope: view_context
          ),
          headers
        )
      end

      private

      def template
        'spree/api/orders/show.v1'
      end

      def endpoint
        '/orders'
      end

      def headers
        {}
      end
    end
  end
end
