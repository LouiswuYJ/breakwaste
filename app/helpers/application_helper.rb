module ApplicationHelper
  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :error then "alert alert-error"
    end
  end
end
