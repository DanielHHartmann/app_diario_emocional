import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {


  static const _model = 'gemini-1.5-flash';



  Future<String> getPhrase(String prompt) async {
    String? apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null){
      return 'Faltou chave de API';
    }

    String  apiUrl =
        'https://generativelanguage.googleapis.com/v1/models/$_model:generateContent?key=$apiKey';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return text?.trim() ?? 'No phrase returned.';
      } else {
        log('Gemini API Error ${response.statusCode}: ${response.body}');
        return 'Could not generate phrase.';
      }
    } catch (e) {
      log('GeminiService Error: $e');
      return 'Failed to connect to Gemini.';
    }
  }
}
