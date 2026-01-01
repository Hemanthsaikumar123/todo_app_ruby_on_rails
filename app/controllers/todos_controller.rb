class TodosController < ApplicationController
    def index
        @todos=Todo.all
    end

    def new
        @todo=Todo.new
    end

    def create
        @todo=Todo.new(todo_params)
        if @todo.save
            redirect_to todos_path
        else
            render :new, status: :unprocessable_entity
        end

    end

    def edit
        @todo=Todo.find_by(id: params[:id])
    end

    def update
        @todo=Todo.find_by(id: params[:id])
        if @todo.update(todo_params)
            redirect_to todos_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @todo=Todo.find_by(id: params[:id])
        @todo.destroy
        redirect_to todos_path
    end

    private
    def todo_params
        params.require(:todo).permit(:title, :completed)
    end
end
