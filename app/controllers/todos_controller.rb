class TodosController < ApplicationController
  before_action :set_todo, only: %i[ edit update destroy ]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1 or /todos/1.json
  def show
    @todo = current_user.todos.find_by(id: params[:id])
    if @todo.nil?
       redirect_to root_path, notice: "HaloOoO nije ovo tvoje "
    end
  end

  # GET /todos/new
  def new
    #@todo = Todo.new
    @todo = current_user.todos.build
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    #@todo = Todo.new(todo_params)
    @todo = current_user.todos.build(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to root_path, notice: "Todo was fakat created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end


    def correct_user
      @todo = current_user.todos.find_by(id: params[:id])
      redirect_to todos_path, notice:"Not authorized to edit this todo" if @todo.nil?
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:todo,:user_id)
    end
end