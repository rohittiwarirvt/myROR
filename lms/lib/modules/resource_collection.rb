module ResourceCollection
  mattr_reader :valid_types do
    RESOURCE_TYPES
  end

  RESOURCE_TYPES.each do |type|
    define_method(type.downcase.pluralize) do
      self.resource.where(type: type)
    end
  end

  def resource_type(type)
    self.send(resource_type.downcase.pluralize.to_sym)
  end

  def order_key(resource_type)
    case resource_type
    when 'Quote','Note'
      :version_order
    else
      :chapter_order
    end
  end

  def resources_order(resource_type)
    list = resource_type(resource_type)
    list.any? ? list.rank(order_key(resource_type)) : list
  end
end
