class TodosController < ApplicationController
    before_action :authenticate_user!

    def index
        @todos=Todo.all
    end

    def new
        @todo=Todo.new
    end

    def create
        @todo=Todo.new(todo_params)
        if @todo.save
            redirect_to todos_path, notice: "Todo was successfully created."
        else
            flash.now[:alert] = "Failed to create todo."
            render :new, status: :unprocessable_entity
        end

    end

    def edit
        @todo=Todo.find_by(id: params[:id])
    end

    def update
        @todo=Todo.find_by(id: params[:id])
        if @todo.update(todo_params)
            redirect_to todos_path, notice: "Todo was successfully updated."
        else
            flash.now[:alert] = "Failed to update todo."
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @todo=Todo.find_by(id: params[:id])
        @todo.destroy
        redirect_to todos_path, notice: "Todo was successfully deleted."
    end

    private
    def todo_params
        params.require(:todo).permit(:title, :completed)
    end
end
