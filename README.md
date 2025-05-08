# Diário Emocional

**Autor**: Daniel Henrique Hartmann  
**Projeto**: Diário Emocional

## 📱 Descrição

O Diário Emocional é um app Flutter que permite ao usuário registrar seus sentimentos diários.
Com base nessas entradas, o aplicativo utiliza o modelo Gemini da Google para gerar frases motivacionais personalizadas, ajudando no bem-estar e na autorreflexão.

## ✨ Funcionalidades

- Registro diário de emoções e anotações
- Calendário com marcações emocionais por dia
- Frases motivacionais geradas por IA (Google Gemini)
- Tema claro/escuro
- Histórico com visualização por calendário e semana
- Botão para limpar o banco de dados local

## 📸 Imagens

### Página Principal
<p align="center">
  <img src="https://github.com/user-attachments/assets/1e321253-8eab-459b-889a-2b741625749a" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/f73f3846-b972-4284-8c6f-4ebf366a19b6" width="30%"/>
</p>

### Menu de Configurações
<p align="center">
  <img src="https://github.com/user-attachments/assets/3dae2693-957b-40d8-b801-e549c257ae55" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/afc3d4e5-ce3e-46cb-9625-8c6f34219633" width="30%"/>
</p>

### Calendário de Sentimento
<p align="center">
  <img src="https://github.com/user-attachments/assets/316c5c59-4210-44f2-addf-9faac909516b" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/aec50cdf-6489-4160-a093-7744d7ae086d" width="30%"/>
</p>

### Tela para Escolher Sentimento
<p align="center">
  <img src="https://github.com/user-attachments/assets/fc3fb39a-9591-42ad-b908-42643d12afb1" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/5c407319-3b70-4467-bae3-bba2a091e327" width="30%"/>
</p>

### Tela para Descrever o Dia
<p align="center">
  <img src="https://github.com/user-attachments/assets/4df831b0-8b6c-4678-8150-5f1cb53830c7" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/882703e0-381c-4be8-aa17-0e76648d932d" width="30%"/>
</p>

### Página Principal com Frase da LLM
<p align="center">
  <img src="https://github.com/user-attachments/assets/762592d0-45cc-4727-853f-580c69607669" width="30%" style="margin-right: 4%;"/>
  <img src="https://github.com/user-attachments/assets/376ac041-c864-46a9-b959-dd243ab5cb73" width="30%"/>
</p>

## 🛠 Tecnologias utilizadas

- Flutter
- Dart
- GetX
- Sqlite
- Google Gemini API (via REST)

## 🧪 Como executar

1. Clone o repositório

   git clone https://github.com/seu-usuario/diario_emocional.git  
   cd diario_emocional

2. Gere uma chave de API Gemini

    Acesse o site oficial da Google AI Studio (Gemini) com sua conta Google.

   https://aistudio.google.com/

    Siga as instruções para obter sua chave da API.

4. Crie um arquivo `.env` na raiz com sua chave da API:

   GEMINI_API_KEY=sua_chave_aqui

5. Instale as dependências

   flutter pub get

6. Rode o app

   flutter run

## 🤖 Como o LLM foi utilizado

Utilizei a API Gemini da Google para gerar frases motivacionais com base no humor do dia e na anotação feita pelo usuário.
O prompt é construído com as informações da entrada e enviado para o modelo, que responde com uma frase inspiradora personalizada.

Foi utilizado o seguinte prompt com o modelo Gemini:

```text
Você é um companheiro encorajador de diário emocional. Responda com uma frase motivacional para este usuário.

Humor: {nome da emoção}
Anotação: {texto escrito pelo usuário}
```

## 📝 Créditos

- Ícone de calendário feito por [Freepik](https://br.freepik.com/icone/calendario_807612#fromView=families&page=1&position=3&uuid=5ce3eac9-90b7-447d-96c0-caacbed20c6a) — Freepik


