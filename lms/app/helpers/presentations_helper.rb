module PresentationsHelper
  def chapter_name
    @chapter_name || @course_section.name
  end
end
