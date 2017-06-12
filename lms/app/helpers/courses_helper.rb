module CoursesHelper
  def expiry_select_options
    if defined?(COURSE_EXPIRY) && COURSE_EXPIRY.is_a?(Hash)
      return COURSE_EXPIRY
    end
    DEFAULT_EXPIRY
  end
end
