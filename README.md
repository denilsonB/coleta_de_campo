# projeto_estagio_tt
O projeto simula o fluxo de um sistema de coleta em campo e visa organizar os dados coletados

## entidades
- Usuário: que identifica e autentica a pessoa no sistema para que ela saiba quais visitas
existem direcionadas a ela
- Visita: que consiste numa tarefa com uma data agendada, e possui informações como,
data de checkin e checkout e usuário responsável por aquela visita
- Formulário: são questionários que englobam várias perguntas específicas de algum
assunto
- Perguntas: são as perguntas do formulario
- Respostas: são as respostas das perguntas

## fluxo de testes

### Primeiro passo 
- O usuário se cadastra no sistema passando suas informações (post_users_spec)
- O usuário efetua o login e recebe o token jwt para validar suas requisições (login_user_spec)

### Segundo passo
- O usuário cria uma visita (post_visits_spec)
- O usuário registra o checkin (checkin_visit_spec)
- O usuário registra o checkout (checkout_visit_spec)
- O usuário lista suas visitas (get_visits_spec)

### Terceiro passo
- O usuário cria um formulario (post_formularies_spec)

### Quarto passo
- O usuário registra as perguntas neste formulario (post_questions_spec)
- O usuário lista as perguntas daquele formulario (get_questions_spec)

### Quinto passo
- O usuário registra as respostas das perguntas (post_answers_spec)
- O usuário lista as respostas da pergunta (get_answers_spec)