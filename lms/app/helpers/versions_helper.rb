module VersionsHelper
  def version_view_path(chapters, version)
    case
    when params[:version_view].eql?('Syllabus')
      render partial: 'course_sections/syllabus',
              locals: { chapters: chapters, version: version}
    else
      render partial: 'basic_information',
             locals: { chapters: chapters, version: version}
    end
  end
end
