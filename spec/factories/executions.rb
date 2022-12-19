FactoryBot.define do
  factory :execution do
    user
    task

    before(:create) do |execution|
      execution.user.update!(role_id: execution.task.role_id)
    end
  end
end
