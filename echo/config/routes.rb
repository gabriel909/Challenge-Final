Rails.application.routes.draw do

  #GET
  #GET Escolas
  get '/escolas', to: 'escola#index'

  #GET Alunos
  get '/alunos', to: 'aluno#index'

  #GET Aluno with id
  get '/alunos/select/:id', to: 'aluno#show'

  #GET Escolas with id
  get '/escolas/select', to: 'escola#show'

  #POST
  #POST Escola signup
  post '/escolas/signup', to: 'escola#create'

  #POST Aluno signup
  post '/alunos/signup', to: 'aluno#create'

  #PUT
  #PUT Escola id
  put '/escola/:id', to: 'escola#update'

  #PUT Aluno id
  put '/aluno/:id', to: 'alunos#update'

  #DELETE
  #DELETE escola
  delete '/escolas/:id', to: 'escola#delete'

  #DELETE Aluno
  delete '/alunos/:id', to: 'aluno#delete'

end
