module ApplicationHelper
  def full_title(page_title='')
    base_title = 'The Witcher 3 Item DB'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
