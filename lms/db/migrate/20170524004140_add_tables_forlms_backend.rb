class AddTablesForlmsBackend < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.timestamps
    end

    create_table :versions do |t|
      t.string  :version, default: "0"
      t.text    :short_description
      t.text    :description, null: false
      t.string  :image
      t.string  :video
      t.integer :expiry
      t.boolean :price
      t.decimal :amount, precision: 5, scale: 2
      t.string  :default_image
      t.integer :prerequisite
      t.boolean :editable, default: true
      t.boolean :published, default: false
      t.timestamps
    end

    create_table :versions_roles, id: false do |t|
      t.belongs_to :role, index: true
      t.belongs_to :version, index: true
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    add_reference :versions, :course, foreign_key: true
    add_reference :versions, :category, foreign_key: true

    create_table :course_sections do |t|
      t.integer :parent_id
      t.string  :name
      t.integer :course_order
      t.integer :chapter_order
      t.boolean :content, default: false
      t.boolean :is_assessment, default: false
      t.timestamps
    end

    add_reference :course_sections, :version, foreign_key: true

    #certificate
    create_table :certificates do |t|
      t.string :name
      t.string :file
      t.text   :short_description
      t.text   :description
    end

    create_table :courses_certificates, id: false do |t|
        t.belongs_to :certificate, index: true
        t.belongs_to :course, index: true
    end
    #certificates_courses

    #interactive_slides
    create_table :interactive_slides do |t|
      t.string   :name
      t.text     :description
      t.string   :type
      t.timestamps
    end

    add_reference :interactive_slides, :version, foreign_key: true
    add_reference :interactive_slides, :course_section, foreign_key: true

    #interactive_slides_informations
    create_table :interactive_slides_informations do |t|
      t.string   :image
      t.string   :title
      t.text     :description
      t.string   :type
      t.timestamps
    end

    add_reference :interactive_slides_informations, :interactive_slide, foreign_key: true

    #custom_contents
    create_table :custom_contents do |t|
      t.string    :title
      t.string    :zip
      t.timestamps
    end

    add_reference :custom_contents, :course_section, foreign_key: true

    #resources
    create_table :resources  do |t|
      t.string :title
      t.string :file
      t.string :type
      t.string :description
      t.text   :content
      t.integer :chapter_order
      t.integer :version_order
      t.timestamps
    end

    add_reference :resources, :course_section, foreign_key: true
    add_reference :resources, :content_section, foreign_key: true
    add_reference :resources, :version, foreign_key: true

    #presentations
    create_table :presentations do |t|
      t.string    :title
      t.timestamps
    end

    add_reference :presentations, :course_section, foreign_key: true
    #slides
    create_table :slides do |t|
      t.string    :title
      t.integer   :number_of_columns, limit: 2
      t.integer   :slides_order
      t.timestamps
    end

    add_reference :slides, :presentation, foreign_key: true

    #slide_contents
    create_table :slides_contents do |t|
      t.text    :content
      t.string  :orientation
      t.string  :file_url
      t.string  :type
      t.timestamps
    end

    add_reference :slides_contents, :slide, foreign_key: true

    #slide_settings
    create_table :slide_settings do |t|
      t.string :background_color , default: "#fffff"
      t.string :background_image
      t.string :transition
      t.timestamps
    end

    add_reference :slide_settings, :slide, foreign_key: true

    # assessments

    create_table :assessments do |t|
      t.string  :name
      t.text    :description
      t.string  :assessment_type
      t.boolean :passing_criteria
      t.float   :passing_percentage, default: 0.0
      t.integer :number_of_displayed_questions
      t.boolean :upfront
      t.boolean  :additional_text
      t.boolean  :details_page
      t.boolean  :randomize
      t.timestamps
    end

    add_reference :assessments, :course_section, foreign_key: true

    #questions_categories
    create_table :questions_categories do |t|
      t.string  :name
    end
    #questions
    create_table  :questions do |t|
      t.text   :title
      t.text   :additional_text
      t.integer :question_order
      t.timestamps
    end

    add_reference :questions, :question_category, foreign_key: true
    add_reference :questions, :assessment, foreign_key: true

    # evaluation questions

    create_table :evaluation_questions do |t|
      t.string  :content
      t.boolean :active
      t.integer :course_order
      t.timestamps
    end

    add_reference :evaluation_questions, :version, foreign_key: true

    # answers  end

    create_table :answers do |t|
      t.string    :option
      t.string    :image
      t.boolean   :correct_answer
      t.timestamps
    end
    add_reference :answers, :question, foreign_key: true

  end
end
