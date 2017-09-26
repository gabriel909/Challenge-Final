Rails.application.routes.draw do

  root 'welcome#index'

  #GET
  #GET Escolas
  get '/escolas', to: 'escolas#index'

  #GET Alunos
  get '/alunos', to: 'alunos#index'

  #GET Aluno with id
  get '/alunos/select/:id', to: 'alunos#show'

  #GET Escolas with id
  get '/escolas/select', to: 'escolas#show'

  #POST
  #POST Escola signup
  post '/escolas/signup', to: 'escolas#create'

  #POST Aluno signup
  post '/alunos/signup', to: 'alunos#create'

  #PUT
  #PUT Escola id
  put '/escolas/:id', to: 'escols#update'

  #PUT Aluno id
  put '/alunos/:id', to: 'alunos#update'

  #DELETE
  #DELETE escola
  delete '/escolas/:id', to: 'escolas#delete'

  #DELETE Aluno
  delete '/alunos/:id', to: 'alunos#delete'

end
