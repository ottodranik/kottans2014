class SqlController < ApplicationController

  def query
    params[:id] = params[:id].to_i
    if params[:id] == 1
      q = 'SELECT tasks.status as status FROM tasks GROUP BY status ORDER BY status ASC'
    elsif params[:id] == 2
      q = 'SELECT projects.id, projects.name, count(tasks.id) as task_count FROM projects LEFT JOIN tasks ON tasks.project_id = projects.id GROUP BY projects.id ORDER BY task_count DESC'
    elsif params[:id] == 3
      q = 'SELECT projects.id, projects.name, count(tasks.id) as task_count FROM projects LEFT JOIN tasks ON tasks.project_id = projects.id GROUP BY projects.id ORDER BY projects.name '
    elsif params[:id] == 4
      q = "SELECT tasks.*, projects.name as project_name FROM tasks LEFT JOIN projects ON projects.id = tasks.project_id WHERE projects.name LIKE 'N%'"
    elsif params[:id] == 5
      q = "SELECT projects.id, projects.name, count(tasks.id) as task_count FROM projects LEFT JOIN tasks ON tasks.project_id = projects.id WHERE projects.name LIKE '%a%' GROUP BY projects.id ORDER BY task_count DESC"
    elsif params[:id] == 6
      q = 'SELECT name, count(*) as count FROM tasks GROUP BY name HAVING count > 1 ORDER BY name ASC'
    elsif params[:id] == 7
      q = "SELECT tasks.name, tasks.status, projects.name, count(*) as count FROM tasks LEFT JOIN projects ON projects.id = tasks.project_id WHERE projects.name = 'Garage' GROUP BY tasks.name, tasks.status HAVING count > 1 ORDER BY count ASC"
    elsif params[:id] == 8
      q = 'SELECT projects.*, count(tasks.id) as count FROM projects LEFT JOIN tasks ON projects.id = tasks.project_id WHERE tasks.status = 1 GROUP BY projects.name HAVING count > 10 ORDER BY projects.id ASC'
    end
    @res = Project.find_by_sql(q)
    render :partial => 'query'
  end



  private

  def task_params
    params.require(:project).permit(:id)
  end


end
