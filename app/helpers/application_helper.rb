module ApplicationHelper
  include Pagy::Frontend

  def linkify(text)
    return "" if text.blank?

    Rinku.auto_link(
      h(text),
      :all,
      'target="_blank" rel="noopener" class="text-blue-600 underline hover:text-blue-800"'
    )
  end
end
