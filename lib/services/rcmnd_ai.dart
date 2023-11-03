// Berkas Dart ini mencakup sebuah kelas 'RecommendationService' yang bertanggung jawab untuk mengambil rekomendasi tugas menggunakan model GPT-3 dari OpenAI.

// Mengimpor paket-paket Dart yang diperlukan dan berkas-berkas khusus proyek.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_todo_list/Models/open_ai_model.dart';
import 'package:simple_todo_list/constants/open_ai.dart';

// Kelas yang bertanggung jawab memberikan rekomendasi tugas.
class RecommendationService {
  // Metode asinkron untuk mendapatkan rekomendasi tugas berdasarkan tugas yang diberikan.
  static Future<GptData> getTugasRecomendations({
    required String tugas,
  }) async {
    try {
      // Tentukan URL ke API OpenAI untuk pengisian teks.
      var url = Uri.parse('https://api.openai.com/v1/completions');

      // Tentukan header yang berisi informasi yang diperlukan untuk permintaan API.
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $apiKey' // Diasumsikan apiKey telah didefinisikan di tempat lain.
      };

      // Siapkan teks permintaan yang akan digunakan untuk menghasilkan rekomendasi tugas.
      String promptData =
          "Saya membutuhkan bantuan seorang ahli to-do list tolong berikan 7 deskripsi to-do list terkait dengan kegiatan $tugas";

      // Enkode data yang diperlukan untuk permintaan GPT-3 dari OpenAI.
      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "temperature": 0.4,
        "max_tokens": 750,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      });

      // Kirim permintaan POST ke API OpenAI untuk pengisian teks.
      var response = await http.post(url, headers: headers, body: data);

      // Parse respons dan konversi menjadi objek GptData.
      return gptDataFromJson(response.body);
    } catch (e) {
      // Lempar pengecualian jika terjadi kesalahan selama permintaan API.
      throw Exception('Kesalahan terjadi saat mengirim permintaan: $e');
    }
  }
}
