import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PromptRepo {
  static Future<Uint8List?> generateImage(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';

      final String apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';
      Map<String, dynamic> headers = {'Authorization': 'Bearer $apiKey'};
      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '31',
        'aspect_ratio': '1:1',
        'cfg': '6',
        'seed': '1',
        'high_res_results': '1'
      };
      final FormData formData = FormData.fromMap(payload);
      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes,
      );
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
