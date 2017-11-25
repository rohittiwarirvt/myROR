module SlideHelper
  def slide_title
    @slide.title && @slide.title.html_safe
  end

  def set_background_color
    "background-color: #{@slide_setting.background_color}"
  end

  def background_image_file_name
    File.basename(@slide_setting.background_image.path) if background_image_exist?
  end

  def background_image_exist?
    @slide_setting.background_image.present?
  end

  def bg_img_title_div
    background_image_exist? || 'hidden-area'
  end

  def active_transition(transition)
    @slide_setting.transition.eql?(transition) ? 'active-transition' : ''
  end

  def set_style
    if background_image_exist?
      set_background_image
    else
      set_background_color
    end
  end

  def set_background_image
    "background-image : url(#{@slide_setting.background_image}"
  end

  def slide_title_class
    'updated-slide-title' if slide_title.present?
  end

  def content_exist(column)
    column.type.blank? ? "": 'hidden-area'
  end

  def text_content_exist(column)
    column.type.eql?('Text') ? '' : 'hidden-area'
  end

  def img_content_exist(column)
    column.type.eql?('Image') ? '' : 'hidden-area'
  end
  def video_content_exist(column)
    column.type.eql?('Video') ? '' : 'hidden-area'
  end

  def file_path(column)
    column.file_url.url || ''
  end

  def column_content(column)
    column.content || ''
  end

end
