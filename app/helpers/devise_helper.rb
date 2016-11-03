# devise helper: error display
module DeviseHelper
  def devise_error_messages!
    resource.errors.full_messages.map { |msg| content_tag(:div, msg, class: 'alert alert-danger', style: 'margin-bottom: 1em;') }.join
  end
end