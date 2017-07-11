APPLICATION_NAME = 'MyLMS'

DEFAULT_EXPIRY =  {
                '1 year from date of user purchase' => '365',
                '6 months from the date of user purchase' => '180',
                '3 months from the date of uesr purchase' => '90'
              }

ACTIVE_CONTROLLERS = %w(assessments questions custom_contents evaluation_questions interactive_slides
                    interactive_slides_informations)
ACTIVE_CLASS = "active"

CATEGORY_TAB = 'categories'

CERTIFICATES_TAB  = 'certficates'

RESOURCE_TYPES = [
  'Video',
  'Document',
  'Quote',
  'Note',
]
