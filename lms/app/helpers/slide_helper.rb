module SlideHelper
  def slide_title
    @slide.title && @slide.title.html_safe
  end
end
