module ApplicationHelper
  include Pagy::Frontend

  def linkify(text)
    return '' if text.blank?

    Rinku.auto_link(
      simple_format(h(text)),
      :all,
      'class="text-blue-600 underline hover:text-blue-800" target="_blank" rel="noopener"'
    ).html_safe
  end
end
