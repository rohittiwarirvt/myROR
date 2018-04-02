module ApplicationHelper
  def set_controller_scope
    controller.controller_name.to_sym
  end

  def localize(key, scope = nil)
    scope =  scope.nil? ? set_controller_scope : [:device] << set_controller_scope
    I18n.t(key, scope:scope)
  end

  def current_year
    Time.new.year
  end

  def parse_json(option)
    JSON.parse(option)
  rescue
    false
  end
end
