# Guia de Boas Práticas para Trabalhar com GitHub em Equipe

## Objetivo

Este guia mostra um fluxo simples e seguro para evitar conflitos, manter o repositório organizado e facilitar o trabalho em equipe.

---

# Fluxo Recomendado Antes de Subir Código

## Atualize seu repositório antes de começar

Sempre pegue as alterações mais recentes antes de programar.

```bash
git pull origin main
```

Isso evita trabalhar em cima de código desatualizado.

---

# Faça suas alterações

Durante o desenvolvimento:

- Escreva código limpo
- Evite arquivos desnecessários
- Não altere código que não pertence à sua tarefa

---

# Formate o código antes do commit

Padronize o código antes de enviar.

## VS Code

```txt
Ctrl + Shift + I
```

Ou:

```txt
Shift + Alt + F
```

Isso ajuda a evitar conflitos por identação e formatação.

---

# Verifique os arquivos alterados

Antes de commitar:

```bash
git status
```

Confira se não existem:

- arquivos temporários
- logs
- arquivos de teste
- credenciais
- arquivos acidentais

---

# Antes do push, atualize novamente

Muito importante em equipes.

```bash
git pull origin main
```

Se houver conflitos:

- Resolva com calma
- Nunca apague código sem revisar
- Teste depois de resolver

---

# Faça o push da branch

```bash
git push origin feature/nome-da-feature
```

Exemplo:

```bash
git push origin feature/tela-login
```

---

# Boas Práticas Importantes

## Sempre faça pull antes de começar

Isso reduz MUITO conflitos.

---

# Fluxo Completo Resumido

```bash
# Atualiza projeto
git pull origin main

# Cria branch
git checkout -b feature/minha-feature # nao precisa dar checkout a nao ser que voce tem alguma branch fora da main
# Desenvolve...

# Formata código

# Verifica alterações
git status

# Adiciona arquivos
git add .

# Commit
git commit -m "feat: adiciona nova funcionalidade"

# Atualiza novamente
git pull origin main

# Push
git push origin feature/minha-feature
```

---

# Dicas Extras

## Nomeie branches corretamente

```txt
feature/login
fix/erro-cadastro
refactor/service-auth
```

---

## Nomeie commits corretamente

```txt
feat: adiciona login JWT
fix: corrige erro de autenticação
docs: atualiza README
```

---

# Conclusão

Seguir esse fluxo ajuda a:

- reduzir conflitos
- organizar o projeto
- melhorar colaboração
- facilitar revisão
- manter histórico limpo no GitHub

Git organizado = menos dor de cabeça.