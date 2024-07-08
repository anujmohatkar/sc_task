module TasksSupport
  extend ActiveSupport::Concern

  private

  def tasks_by_tab_status
    case params[:tab_status]
    when 'overdue'
      current_user.tasks.where('due_date < ?', Date.today).where.not(status: 'completed')
    when 'completed'
      current_user.tasks.where(status: 'completed')
    when "show"
      @tab_status.nil? ? [@task] : current_user.tasks.all
    else
      current_user.tasks.all
    end
  end

  def set_tab_status
    if ['all', 'completed', 'overdue'].any? { |s| s == params[:tab_status] }
      params[:tab_status]
    else
      "all"
    end
  end
end