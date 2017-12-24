namespace :import do
  desc "Imporint roles for verions"
  task :seedquestioncategories => :environment do
    questioncategories = [
      'descriptive',
      'match_the_pairs',
      'multiple_answers',
      'multiple_matching',
      'multiple_visuals',
      'single_answer',
      'single_visual',
      'sorting',
      'true_or_false'
    ]

    questioncategories_collection = questioncategories.map { |question_category| [name:question_category]}

    questioncategories = QuestionCategory.create(questioncategories_collection)
  end
end
