module CommonHelper
  def active_class_name(tab)
    return 'active' if tab == controller_name
    'active' if ([CATEGORY_TAB, CERTIFICATES_TAB] &
                   [tab, controller_name]).empty?
  end

  def active_class
    (ACTIVE_CONTROLLERS.include? controller_name) && ACTIVE_CLASS
  end

  def current_year
    Time.new.year
  end
end
