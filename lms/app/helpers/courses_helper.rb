module CoursesHelper
  def expiry_select_options
    if defined?(COURSE_EXPIRY) && COURSE_EXPIRY.is_a?(Hash)
      return COURSE_EXPIRY
    end
    DEFAULT_EXPIRY
  end

  def user_role
    version_roles = []
    unless version_roles.blank?
      @version_roles.each do |user_role|
        version_roles.push user_role.role_id
      end
    end
    version_roles
  end
end
