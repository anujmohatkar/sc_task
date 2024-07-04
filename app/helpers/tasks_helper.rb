module TasksHelper
  # provides humanized date for showing the due date of a task
  def format_due_date(due_date)
    current_date = DateTime.now
    days_difference = (due_date.to_date - current_date.to_date).to_i
    days_text = days_difference.abs == 1 ? "day" : "days"

    relative_text = if days_difference < 0
                      "ago"
                    elsif days_difference > 0
                      "from now"
                    else
                      "today"
                    end

    formatted_date = due_date.strftime("%d %B %Y")

    "#{days_difference.abs} #{days_text} #{relative_text} (#{formatted_date})"
  end

  # provides color according to the status of the task which is then used for setting card related colors
  def status_color(status)
    case status
    when "pending"
      return "danger"
    when "in_progress"
      return "warning"
    when "completed"
      return "success"
    end
  end
end
