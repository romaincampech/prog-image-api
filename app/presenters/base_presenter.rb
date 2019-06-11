class BasePresenter
  def initialize(object)
    @object = object
  end

  protected

  attr_reader :object
end
