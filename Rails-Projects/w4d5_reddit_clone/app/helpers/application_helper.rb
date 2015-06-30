module ApplicationHelper
  def csrf_tag
    html = <<-HTM
          <input
            type="hidden"
            name="authenticity_token"
            value="#{form_authenticity_token}">
    HTM
    html.html_safe
  end
end
