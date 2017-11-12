module SlideHelper
  def slide_title
    @slide.title && @slide.title.html_safe
  end

  def set_background_color
    "background-color: #{@slide_setting.background_color}"
  end

  def background_img_file_name
    File.basename(@slide_setting.background_img.path) if background_img_exist?
  end

  def background_img_exist?
    @slide_setting.background_img.path.present?
  end

  def bg_img_title_div
    background_img_exist? || 'hidden-area'
  end

  def active_transition(transition)
    @slide_setting.transition.eql?(transition) ? 'active-transition' : ''
  end
end
