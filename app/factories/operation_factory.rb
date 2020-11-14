class OperationFactory
  ACTIONS_MAP = {
    index: :list,
    show: :detail
  }.freeze

  def from_controller(controller)
    module_name = controller.controller_name
    action_name = controller.action_name.to_sym
    class_name = ACTIONS_MAP.fetch(action_name, action_name)

    Entregis::Container.resolve("#{module_name}.#{class_name}_operation")
  end
end
