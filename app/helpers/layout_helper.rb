module LayoutHelper
  def try_render(template)
    render template
  rescue ActionView::MissingTemplate
    yield if block_given?
  end
end
