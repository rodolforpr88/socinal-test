class Execution < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validate :user_and_task_roles_match

  def try_update(user, params)
    try_with_role("execution.update", user) { update(params) }
  end

  def try_destroy(user)
    try_with_role("execution.destroy", user) { destroy }
  end

  private

  def user_and_task_roles_match
    return if user && task && user.role_id == task.role_id

    errors.add(:user, "doesn't have a matching role for the task")
  end

  def try_with_role(role, user)
    if user.role.name == role
      yield
    else
      errors.add(:user, "doesn't have a allowed role")
      false
    end
  end
end
