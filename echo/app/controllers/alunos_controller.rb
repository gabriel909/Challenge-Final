class AlunosController < ApplicationController
  before_action :set_medico, only: [:show, :delete, :update]

  #GET /alunos
  def index
    @alunos = Aluno.all
    json_response @alunos
  end

  #GET /alunos/:id
  def show
    json_response @aluno
  end

  #POST /alunos/signup
  def create
    @aluno = Aluno.create! aluno_params
    #TODO Auth token

    json_response @aluno
  end

  #PUT
  #PUT /alunos/:id
  def update
    delete_update do
      @aluno.update aluno_params
      json_response @aluno
    end
  end

  #DELETE
  #DELETE /alunos/:id
  def destroy
    delete_update do
      @aluno.destroy
      head :no_content
    end
  end

  private

  def aluno_params
    params.permit :email, :password, :nome, :serie
  end

  def set_aluno
    @aluno = Aluno.find params[:email]
  end

  def delete_update
    #TODO
    yield
  end
end
