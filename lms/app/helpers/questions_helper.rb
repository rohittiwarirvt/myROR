module QuestionsHelper
  def required_question_count(count)
    count.present? ? count : 0
  end

  def eligible_reorder_question
    @assessment.randomize || 're-position'
  end

  def correct_answer(correct_answer)
    return unless correct_answer
    haml_tag :div, class: 'correct-ans'
  end

  def order_options(answer_options)
    answer_options.order(:id)
  end

  def category_list(list)
    return unless list.any?
    categorylist = {}
    list.each do |category|
      categorylist[:"#{category.id}"] =
        localize("form.category.#{category.name}")
    end
    categorylist
  end

  def editable_element
    return true unless @version.editable?
    @version.published
  end

  def format_option(option)
    option_value = parse_json(option)
    return option unless option_value.present?
    "#{option_value.keys.first} : #{option_value.values.join(',')}"
  end
end
