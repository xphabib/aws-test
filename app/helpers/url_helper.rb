module UrlHelper
  def url_path
    base = request.base_url
    path = request.path
    if request.path == '/clipchamp-videos-show'
      path = '/clipchamp-videos'
    end
    base + path
  end

  def nav_active(controller_name, action_name)
    if controller.controller_name == controller_name && controller.action_name == action_name
      return 'active'
    end
  end

  def nav_query_path(link)
    if params[:query].present?
      link + '?query=' + params[:query]
    else
      link
    end
  end
end