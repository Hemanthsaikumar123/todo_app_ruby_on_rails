class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:edit, :update, :destroy]

  def index
    @todos = current_user.todos
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.new(todo_params)

    if @todo.save
      redirect_to todos_path, notice: "Todo was successfully created."
    else
      flash.now[:alert] = "Failed to create todo."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: "Todo was successfully updated."
    else
      flash.now[:alert] = "Failed to update todo."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todo was successfully deleted."
  end

  private

  # ✅ only current_user’s todos can be accessed
  def set_todo
    @todo = current_user.todos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todos_path, alert: "You are not authorized to access that todo."
  end

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
