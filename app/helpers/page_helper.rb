module PageHelper
  def page_count
    if params[:page].present?
      page = params[:page].to_i + 1
    else
      page = 2
    end
    page
  end
end