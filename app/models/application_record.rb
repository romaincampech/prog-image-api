class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def is_an_image?
    return true if self.is_a?(Image)

    false
  end

  def is_an_image_transformation?
    return true if self.is_a?(ImageTransformation)

    false
  end
end
