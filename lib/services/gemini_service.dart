import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class GeminiService {
  static const _apiKey = 'AIzaSyBzwiy9NAlFkMl56cLwUiFDAYKcUJRosk4';
  static const _model = 'gemini-1.5-flash';

  static const _apiUrl =
      'https://generativelanguage.googleapis.com/v1/models/$_model:generateContent?key=$_apiKey';

  Future<String> getPhrase(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
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
