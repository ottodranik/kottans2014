json.array! @projects do |project|
  json.extract! project, :id, :name, :position, :user_id
  json.url project_url(project, format: :json)

  json.tasks project.tasks do |task|
    json.extract! task, :id, :name, :position, :project_id, :deadline
    json.status task.status.to_s
    json.url project_tasks_url(task, format: :json)
  end
end