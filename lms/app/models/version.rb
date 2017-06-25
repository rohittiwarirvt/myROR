class Version < ActiveRecord::Base
  belongs_to :course
  belongs_to :category
  has_many :course_sections, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :evaluation_questions, dependent: :destroy
  has_and_belongs_to_many :version_roles, join_table: 'versions_roles', class_name: 'Role'
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  accepts_nested_attributes_for :version_roles

  def update_role(roles)
    version_roles.destroy_all && version_roles<<roles
  end

  def self.list_courses(page = nil)
    includes(:course, :category)
    .order('versions.id DESC')
    .page(page).per(10)
  end

  def self.search_courses(pages = nil, keyworkd = nil)
    includes(:coures, :category).where('LOWER(name) LIKE LOWER(?)', '%' +
     keyboard.to_s + '%').order('versions.id DESC').references(:course).page(page).per(10)
  end

  def chapters
    course_sections.chapters.rank(:course_order)
  end

  def publishable?
    return false if course_sections.chapters.size.zero?
    course_sections.chapters.each do |chapter|
      return false unless chapter.contents.any? && chapters.section_present?
    end
    true
  end

  def editable?
    return true if editable && !published
    errors[:published] << "Cant edit The course" if published
    errors[:purchased] << "Cant Edit because course has been purchased" unless editable
    false
  end

end
