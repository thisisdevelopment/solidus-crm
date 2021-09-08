# This module is responsible for passing the solidus states to the external event queue.
module SolidusCrm
  module OrderStatemachine
    extend ActiveSupport::Concern

    included do
      state_machine do
        after_transition to: %i[delivery payment canceled complete], do: :update_crm
      end
    end
    def update_crm(transition)
      Spree::CrmConfig.crm_order_emitter_class.new(self, state, transition.from_name, transition.to_name).emit
    end
  end
end
