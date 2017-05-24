class AddTablesForlmsBackend < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.timestamps
    end

    create_table :versions do |t|
      t.string  :version, default: "0"
      t.text    :description, null :false
      t.string  :image
      t.string  :video
      t.integer :expiry
      t.boolean :price
      t.string  :default_image
      t.integer :prerequisite
      t.boolean :editable
      t.boolean :published
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    add_reference :versions, :courses, foreign_key: true
    add_reference :versions, :categories, foreign_key: true

    create_table :course_sections do |t|
      t.integer :parent_id
      t.string  :name
      t.integer :course_order
      t.integer :chapter_order
      t.boolean :content, default: false
      t.timestamps  
    end

    add_reference :course_sections, :versions, foreign_key: true
    
    #certificate
    #interactive_slides
    #interactive_slides_informations
    #questions
    #questions_categories
    #resources
    #custom_contents
    #resources
    create_table :resources  do |t|
      
    end
    #presentations
    #slides
    #slide_contents
    #slide_settings
    # assessment
    # evaluation questions
    # answers

  end
end
