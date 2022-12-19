# Socinal - Teste Técnico

## Resumo

O teste se baseia em uma aplicação de registro de tarefas. Nela existem as seguintes rotas em sua API:

- `/users` - Cadastros de usuários
- `/users/:user_id/role` - A permissão que um usuário possui
- `/tasks` - Cadastros de tarefas, que podem ser realizadas diversas vezes
- `/tasks/:task_id/executions` - Registros de todas as vezes que uma tarefa foi realizada (execuções)

Permissões são usadas para controlar o que os usuários podem fazer no sistema.

Cada tarefa possui uma permissão associada.

Para criar uma execução de uma tarefa, o usuário precisa ter a mesma permissão (`user.role == task.role`).

Para atualizar uma execução, o usuário precisa ter a permissão `execution.update`.

Para remover uma execução, o usuário precisa ter a permissão `execution.destroy`.

## Objetivo

A aplicação está estruturada de forma que cada usuário possui apenas 1 permissão, e dependendo do que ele pretende fazer, essa permissão precisa ser frequentemente alterada.

Seu objetivo é entender a aplicação através dos testes, e adicionar a funcionalidade de adicionar e remover múltiplas permissões por usuário.

Você deve usar o recurso `nested_attributes` do ActiveRecord para receber os registros na API, e alterar todos os pontos do código que usavam a implementação antiga.

## Submissão

Faça um clone do projeto e crie um pull-request para submeter seu teste quando estiver finalizado.

Lembre-se de alterar e incluir novos testes se achar necessário.
