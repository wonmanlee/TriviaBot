module ApplicationHelper
  def flash_class(level)
    case level
      when "success" then "alert alert-success"
      when "notice" then "alert alert-info"
      when "error" then "alert alert-warning"
      when "alert" then "alert alert-danger"
    end
  end
end
