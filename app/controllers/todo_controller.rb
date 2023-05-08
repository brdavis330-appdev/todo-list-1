class TodoController < ApplicationController
  def index
    matching_todo = Todo.all

    @list_of_todo = matching_todo.order({ :created_at => :desc })

    render({ :template => "todo/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_todo = Task.where({ :id => the_id })

    @the_todo = matching_tasks.at(0)

    render({ :template => "tasks/show.html.erb" })
  end

  def create
    the_todo = Todo.new
    the_todo.description = params.fetch("query_description")
    the_todo.status = params.fetch("query_status")
    the_todo.user_id = params.fetch("query_user_id")

    if the_todo.valid?
      the_todo.save
      redirect_to("/", { :notice => "Task created successfully." })
    else
      redirect_to("/", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.description = params.fetch("query_description")
    the_todo.status = params.fetch("query_status")
    the_todo.user_id = params.fetch("query_user_id")

    if the_todo.valid?
      the_todo.save
      redirect_to("/", { :notice => "Task updated successfully."} )
    else
      redirect_to("/", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/", { :notice => "Task deleted successfully."} )
  end
end
