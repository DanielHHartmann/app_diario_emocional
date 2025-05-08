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


