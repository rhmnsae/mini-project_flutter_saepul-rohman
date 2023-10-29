import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_todo_list/Models/open_ai_model.dart';
import 'package:simple_todo_list/constants/open_ai.dart';

class RecommendationService {
  static Future<GptData> getTugasRecomendations({
    required String tugas,
  }) async {
    try {
      var url = Uri.parse('https://api.openai.com/v1/completions');

      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $apiKey'
      };

      String promptData =
          "Saya membutuhkan bantuan seorang ahli to-do list tolong berikan 7 deskripsi to-do list terkait dengan kegiatan $tugas";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "temperature": 0.4,
        "max_tokens": 750,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      });

      var response = await http.post(url, headers: headers, body: data);
      return gptDataFromJson(response.body);
    } catch (e) {
      throw Exception('Error occured when sending request.');
    }
  }
}
