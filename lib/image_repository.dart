import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageRepository {
  final url = Uri.parse('https://dog.ceo/api/breeds/image/random');
  Future<String> getImageUrl() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }

    throw Exception();
  }
}
